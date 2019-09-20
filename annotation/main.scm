;;; MOZI-AI Annotation Scheme
;;; Copyright © 2019 Abdulrahman Semrie
;;; Copyright © 2019 Hedra Seid
;;;
;;; This file is part of MOZI-AI Annotation Scheme
;;;
;;; MOZI-AI Annotation Scheme is free software; you can redistribute
;;; it and/or modify it under the terms of the GNU General Public
;;; License as published by the Free Software Foundation; either
;;; version 3 of the License, or (at your option) any later version.
;;;
;;; This software is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this software.  If not, see
;;; <http://www.gnu.org/licenses/>.


(define-module (annotation main)
    #:use-module (annotation util)
    #:use-module (annotation gene-go)
    #:use-module (annotation gene-pathway)
    #:use-module (annotation biogrid)
    #:use-module (annotation parser)
    #:use-module (opencog)
    #:use-module (opencog query)
    #:use-module (opencog exec)
    #:use-module (opencog bioscience)
    #:use-module (json)
    #:use-module (ice-9 match)
    #:use-module (ice-9 threads)
    #:use-module (rnrs base)
    #:use-module (ice-9 futures)
)

(define-public (find-genes gene-list)
  "Validate if given gene strings in GENE-LIST exist in the
atomspace."
  (let ((unknown (filter (lambda (gene)
                           (null? (cog-node 'GeneNode gene)))
                         gene-list)))
    (match unknown
      (() "0")
      (_ (string-append "1:" (string-join unknown ","))))))

(define-public (gene-info genes id)
  "Add the name and description of gene nodes to the given list of GENES."
  (let* ((info
         (map (lambda (gene)
                (list (ListLink (node-info (GeneNode gene))
                                (ListLink (locate-node (GeneNode gene))))))
              genes))
              
        (res (ListLink (ConceptNode "main") info))     
        )
        (write-to-file res id "main")
        res
   ;(atomese-parser (format #f "~a" (ListLink (ConceptNode "main") info)))
  )
)

(define-public (mapSymbol gene-list)
  "Map gene symbols into GeneNodes."
  (map GeneNode gene-list))
(define-public (annotate-genes gene-list file-name annts-fns)
  (parameterize ( (nodes '()) 
                  (edges '()) 
                  (atoms '()) 
                  (genes gene-list)
                  (biogrid-genes '())
                  (biogrid-pairs '())
                  (annotation "")
                  (prev-annotation "")
              )
      (let-values (
        [result (force annts-fns)]
        )
         (scm->json-string (atomese-parser (format #f "~a" result)))
      )
  )
)






