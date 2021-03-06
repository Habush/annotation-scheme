(define-module (tests util-test)
    #:use-module (srfi srfi-64)
    #:use-module (opencog)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (annotation util)

)

(test-begin "util")
(setenv "TEST_MODE" "TRUE")
(primitive-load-path "tests/sample_dataset.scm")
(define entrez-link (EvaluationLink
        (PredicateNode "has_entrez_id")
        (ListLink 
	(GeneNode "IGF1")
	(ConceptNode "entrez:3479"))))


(test-assert "build-desc-go"  (string=? "http://amigo.geneontology.org/amigo/term/GO:1902430" (build-desc-url "GO:1902430" "biologicalprocess")))

(test-assert "build-desc-prot"  (string=? "https://www.uniprot.org/uniprot/P4354" (build-desc-url "P4354" "uniprot")))

(test-assert "build-desc-prot"  (string=? "https://www.uniprot.org/uniprot/P4354" (build-desc-url "P4354" "uniprot")))

(test-assert "build-desc-gene"  (string=? "https://www.ncbi.nlm.nih.gov/gene/3479" (build-desc-url "IGF1" "gene")))

(test-assert "similar-genes" (= 5 (length (find-similar-gene "IGF"))))

(clear)

(setenv "TEST_MODE" #f) ;;remove the env variable
(test-end "util")
