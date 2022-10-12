  #excel to archimate (WIP)
  
  
  ## notes
  
  319  java -jar xsd2owl/target/xsd2owl-0.0.1-SNAPSHOT-jar-with-dependencies.jar
  320  comunica-sparql-file result.n3 "SELECT * WHERE { ?s ?p ?o } LIMIT 100" -t 'application/sparql-results+xml' > binding.xml
  321  xsltproc sparql2archimate.xslt binding.xml 

