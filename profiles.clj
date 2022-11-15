{:user {:dependencies [;; repl
                       [nrepl "RELEASE"]
                       [io.aviso/pretty "RELEASE"]
                       [djblue/portal "RELEASE"]
                       [vlaaad/reveal "RELEASE"]
                       [clj-commons/pomegranate "RELEASE"]
                       [org.clojure/tools.namespace "RELEASE"]
                       [com.gfredericks/dot-slash-2 "RELEASE"]
                       ;; spec & type
                       [expound "RELEASE"]
                       [orchestra "RELEASE"]
                       [org.typedclojure/typed.clj.checker "RELEASE"]
                       [org.typedclojure/typed.clj.runtime "RELEASE"]
                       [org.typedclojure/typed.clj.spec "RELEASE"]
                       [org.typedclojure/typed.lib.clojure "RELEASE"]
                       [org.typedclojure/typed.lib.spec.alpha "RELEASE"]
                       ;; testing
                       [criterium "RELEASE"]
                       [org.clojure/test.check "RELEASE"]
                       [com.hyperfiddle/rcf "RELEASE"]
                       ;; debugger
                       [postmortem "RELEASE"]
                       [com.github.jpmonettas/flow-storm-inst "RELEASE"]
                       [com.github.jpmonettas/flow-storm-dbg "RELEASE"]]


        :plugins [[cider/cider-nrepl "RELEASE"]
                  [com.github.liquidz/antq "RELEASE"]
                  [io.aviso/pretty "RELEASE"]]

        :middleware [io.aviso.lein-pretty/inject]

        :repl-options {:init-ns user
                       :init (do (require '[typed.clojure :as type])
                                 (require '[flow-storm.api :as dbg]))}

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
