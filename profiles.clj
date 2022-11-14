{:user {:dependencies [[criterium "RELEASE"]
                       [expound "RELEASE"]
                       [orchestra "RELEASE"]
                       [nrepl "RELEASE"]
                       [postmortem "RELEASE"]
                       [clj-commons/pomegranate "RELEASE"]
                       [org.clojure/test.check "RELEASE"]
                       [org.clojure/tools.namespace "RELEASE"]
                       [com.gfredericks/dot-slash-2 "RELEASE"]
                       [com.github.jpmonettas/flow-storm-inst "RELEASE"]
                       [com.github.jpmonettas/flow-storm-dbg "RELEASE"]
                       [djblue/portal "RELEASE"]
                       [vlaaad/reveal "RELEASE"]]

        :plugins [[cider/cider-nrepl "RELEASE"] [com.github.liquidz/antq "RELEASE"]]

        ; :repl-options {:nrepl-middleware [vlaaad.reveal.nrepl/middleware]}

        :injections [(do (require 'com.gfredericks.dot-slash-2)
                         ((resolve 'com.gfredericks.dot-slash-2/!)
                          '{. [clojure.repl/dir
                               clojure.repl/doc
                               clojure.repl/find-doc
                               clojure.repl/source
                               clojure.repl/pst
                               clojure.pprint/pp
                               clojure.pprint/pprint
                               clojure.tools.namespace.repl/refresh
                               clojure.tools.namespace.repl/refresh-all
                               criterium.core/bench
                               criterium.core/quick-bench
                               {:var flow-storm.api/local-connect :name debug}]}))]}}
