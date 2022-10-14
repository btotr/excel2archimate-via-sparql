# excel to archimate (WIP)
  
##proces
### convert excel to rdf
```
excel2rdf instances/portfolio.xlsx portfolio.ttl
```
 
### convert archimate to rdf
Makes use of xsd2owl (some modifications in resources mapper)
```
java -jar xsd2owl/target/xsd2owl-0.0.1-SNAPSHOT-jar-with-dependencies.jar
```
  
### join the files and query all instances
```
comunica-sparql-file result.n3 portfolio.ttl "SELECT * WHERE { ?s ?p ?o } LIMIT 100" -t 'application/sparql-results+xml' > binding.xml
```
 
### convert back to archimate
```
xsltproc sparql2archimate.xslt binding.xml
```

