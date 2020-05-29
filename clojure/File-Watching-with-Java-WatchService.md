## File watching with Java WatchService

We can use Java WatchService interface to monitor file and folder changes on a certain directory.

### Intro in Java

`WatchService` works by registering the paths and actions we want to monitor:

```java
Path path = Paths.get(".");
WatchService watchService =  path.getFileSystem().newWatchService();
path.register(
  watchService, 
  StandardWatchEventKinds.ENTRY_MODIFY,
  StandardWatchEventKinds.ENTRY_CREATE,
  StandardWatchEventKinds.ENTRY_DELETE
);
```
This means that a watcher will be monitoring the current directory (not recursive!) for modifications, creations and deletions. As you may notice, there's no callback, and we will need to fetch those file changes from the watcher, and this can be done in two manners, with polling and without polling the watcher.

#### With polling (method `poll`)

From the Java docs, it "retrieves and removes the next watch key, or null if none are present."

```java
WatchKey watchKey = null;
while (true) {
    watchKey = watchService.poll(10, TimeUnit.MINUTES);
    if(watchKey != null) {
        watchKey.pollEvents().stream().forEach(event -> System.out.println(event.context()));
    }
    watchKey.reset();
}
```

(from https://www.javamex.com/tutorials/io/file_system_watch_polling.shtml)

In this example, a lot of CPU will be burned, so another approach would be to use a pool of threads instead of a while true loop, or increase the timeout.

#### Without polling (method `take`)

Different from `poll`, `take` is blocking, and will keep blocking until a value is returned, from the Java docs, it "retrieves and removes next watch key, waiting if none are yet present."

```java
WatchKey key;
while ((key = watchService.take()) != null) {
    for (WatchEvent<?> event : key.pollEvents()) {
        System.out.println(
          "Event kind:" + event.kind() 
            + ". File affected: " + event.context() + ".");
    }
    key.reset();
}
```

(from https://www.baeldung.com/java-nio2-watchservice)

### In Clojure

```clj
(import (java.io File)
        (java.nio.file FileSystems StandardWatchEventKinds WatchService Path)
        (java.util.concurrent TimeUnit))

(def dir-path ".")

(defn register! [dir-path]
  (let [watchService (.newWatchService (FileSystems/getDefault))
        filePath (. (clojure.java.io/file dir-path) toPath)]
    (.register filePath
               watchService
               (into-array [StandardWatchEventKinds/ENTRY_DELETE
                            StandardWatchEventKinds/ENTRY_MODIFY
                            StandardWatchEventKinds/ENTRY_CREATE]))
    watchService))

(defn watcher-without-poll [watchService]
  (when-let [w-key (.take watchService)]
    (doseq [event (.pollEvents w-key)]
      (println (str "Event kind: " (.kind event) " | Item affected: " (.context event))))
    (.reset w-key)
    (recur watchService)))

(defn watcher-with-poll [watchService]
  (when-let [w-key (.poll watchService (long 5) TimeUnit/SECONDS)]
    (doseq [event (.pollEvents w-key)]
      (println (str "Event kind: " (.kind event) " | Item affected: " (.context event))))
    (.reset w-key))
  (recur watchService))

(defn start! [watcher]
  (let [watchService (register! dir-path)]
    (watcher watchService)))

(start! watcher-with-poll)
;; OR
(start! watcher-without-poll)
```
```
Event kind: ENTRY_CREATE | Item affected: fsfsdfgdgffdgsd
Event kind: ENTRY_CREATE | Item affected: fgdgffdgsd
Event kind: ENTRY_MODIFY | Item affected: .git
Event kind: ENTRY_MODIFY | Item affected: .git
Event kind: ENTRY_DELETE | Item affected: fsfsdfgdgffdgsd
```

*Heads up:* In MacOS, the ServiceWatcher is A LOT slower than in Linux. The following stackoverflow answer explains it well:

> JDK 7 does not yet have a native implementation of WatchService for MacOS. Rather than listening for native file system events, it uses the fallback sun.nio.fs.PollingWatchService, which periodically traverses the file system and checks the last modified timestamp of each file and subdirectory in the tree. I've also found it to be unusably slow.
