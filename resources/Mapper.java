/*
 * Licensed under the Apache License, Version 2.0 (the "License"); you 
 * may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.nasa.jpl.mudrod.xsd2owl;

import java.io.File;
import java.io.FileOutputStream;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.srdc.ontmalizer.XSD2OWLMapper;
import tr.com.srdc.ontmalizer.XML2OWLMapper;


/**
 * @author lewismc
 *
 */
public class Mapper {
    
    private static final Logger LOG = LoggerFactory.getLogger(Mapper.class);

    /**
     * 
     */
    public Mapper() {
        // default constructor
    }

    public void executeMapping() {
	      // This part converts XML schema to OWL ontology.
	    XSD2OWLMapper mapping = new XSD2OWLMapper(new File("instances/archimate3_Model.xsd"));
	    mapping.setObjectPropPrefix("");
	    mapping.setDataTypePropPrefix("");
	    mapping.convertXSD2OWL();

	    // This part converts XML instance to RDF data model.
	    XML2OWLMapper generator = new XML2OWLMapper(
		new File("instances/model.xml"), mapping);
	    generator.convertXML2OWL();
	    
	    // This part prints the RDF data model to the specified file.
	    try{
		File f = new File("result.n3");
		File owl = new File("result.owl");
		//f.getParentFile().mkdirs();
		FileOutputStream fout = new FileOutputStream(f);
		FileOutputStream ont = new FileOutputStream(owl);
		generator.writeModel(fout, "N3");
		mapping.writeOntology(ont, "N3");
		ont.close();
		fout.close();

	    } catch (Exception e){
		e.printStackTrace();
	    }
    }
    /**
     * @param args
     */
    public static void main(String[] args) {
 
        Mapper mapper = new Mapper();
        mapper.executeMapping();
    }

}
