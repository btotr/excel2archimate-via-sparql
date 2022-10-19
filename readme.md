# excel to archimate

This repository has some helper files to convert data from excel to archimate.
It mainly uses other tools to convert the intermediate states


## workflow

### convert excel to rdf
use [excel2rdf](https://github.com/edmondchuc/excel2rdf)

```
excel2rdf instances/import.xlsx import.ttl
```
 
### convert archimate to rdf
Makes use of [ontmalizer](https://github.com/btotr/ontmalizer) wrapper [xsd2owl](https://github.com/mudrod/xsd2owl) 
some small modifications could be found in resources folder (mapper.java)

This workflow expects a model.xml in an instances folder together with the xsd (archimate3_Model.xsd). 

```
java -jar xsd2owl/target/xsd2owl-0.0.1-SNAPSHOT-jar-with-dependencies.jar
```
this produce a file called result.n3 and result.owl, the instances ant ontology respectivly.

### construct new instances and join the files
Use [comunica-sparql-file](https://comunica.dev/docs/query/getting_started/query_cli_file/) to join the excel instatance with archimate instances. 

```
comunica-sparql-file result.n3 import.ttl -f queries/constructProperties.sparql > construct.ttl
comunica-sparql-file result.n3 import.ttl construct.ttl "SELECT * WHERE { ?s ?p ?o }" -t 'application/sparql-results+xml' > binding.xml
```
 
### convert back to archimate
```
time xsltproc sparql2archimate.xslt binding.xml | tee archimate.xml
```

