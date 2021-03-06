(define-module (tests pathway-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation biogrid)
    #:use-module (annotation functions)
    #:use-module (annotation util)
    #:use-module (annotation biogrid-helpers)
)


(test-begin "pathway")
(setenv "TEST_MODE" "TRUE")
;; Load test atomspace
(primitive-load-path "tests/sample_dataset.scm")

(test-equal "pathway-interactors" 2 (length (pathway-gene-interactors  (Reactome "R-HSA-114608"))))

(clear)
(setenv "TEST_MODE" #f) ;;remove the env variable
(test-end "pathway")
