<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.opengroup.org/xsd/archimate/3.0/" 
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:owl="http://www.w3.org/2002/07/owl#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:sparql="http://www.w3.org/2005/sparql-results#"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<xsl:output method="xml" 
		indent="yes" />
		<xsl:strip-space elements="*"/>
  		<xsl:template match="sparql:results" >
  			<model xmlns="http://www.opengroup.org/xsd/archimate/3.0/" 
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
				xsi:schemaLocation="http://www.opengroup.org/xsd/archimate/3.0/ http://www.opengroup.org/xsd/archimate/3.1/archimate3_Diagram.xsd" 
				identifier="id-c7e68948bd76413c9085d574b145eb21">
				<name xml:lang="en">
		    			<xsl:value-of select="'model'"/>
					</name>
					<elements>
						<xsl:for-each select="sparql:result[sparql:binding[@name='p']/sparql:uri/text() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type']">
						<xsl:call-template name="result"/>
		    		</xsl:for-each>
			  	</elements>
			  	<!--relationships>
  				<xsl:for-each select="sparql:result">
	  				<xsl:call-template name="relationship"/>
		    		</xsl:for-each>
			  	</relationships>
			  	<propertyDefinitions>
				<xsl:for-each select="sparql:result">
	  				<xsl:call-template name="propertyDefinition"/>
		    		</xsl:for-each>
			  	</propertyDefinitions-->
			</model>
		</xsl:template>	
		
		<xsl:template name="result">
			<xsl:variable name="s" select="./sparql:binding[@name='s']" />
			<xsl:variable name="p" select="./sparql:binding[@name='p']" />
			<xsl:variable name="o" select="./sparql:binding[@name='o']" />
			<xsl:variable name="uri" select="$s/sparql:uri/text()" />
			<xsl:variable name="type" select="substring-after($o, '#')" />
				<xsl:if test="	$type = 'Capability' or 
												$type = 'Outcome' or 
												$type = 'WorkPackage'">
					<element>
						<xsl:attribute name="xsi:type">
							<xsl:value-of select="$type"/>
						</xsl:attribute>	
						<xsl:for-each select="//sparql:result[sparql:binding[@name='s']/sparql:uri/text() = $uri]">
									<xsl:variable name="property" select="sparql:binding[@name='p']/sparql:uri/text()" />
								
									<xsl:if test="$property = 'http://www.opengroup.org/xsd/archimate/3.0/#identifier'">
											<xsl:attribute name="identifier">
												<xsl:value-of select="sparql:binding[@name='o']/sparql:literal"/>
											</xsl:attribute>
									</xsl:if>	
									
						</xsl:for-each>	
						<xsl:for-each select="//sparql:result[sparql:binding[@name='s']/sparql:uri/text() = $uri]">
									<xsl:variable name="property" select="sparql:binding[@name='p']/sparql:uri/text()" />
									<xsl:if test="$property = 'http://www.opengroup.org/xsd/archimate/3.0/#name'">
										<name xml:lang="en">
											<xsl:value-of select="sparql:binding[@name='o']"/>
		    						</name>
	  							</xsl:if>
										
									<xsl:if test="$property = 'http://www.opengroup.org/xsd/archimate/3.0/#properties'">
										<properties>
											<xsl:call-template name="properties">
												<xsl:with-param name="propertiesType" select="sparql:binding[@name='o']" />
											</xsl:call-template>
										</properties>
									</xsl:if>
								</xsl:for-each>	
							</element>
						</xsl:if>
	</xsl:template>

	<xsl:template name="relationship">
		<xsl:variable name="uri" select="sparql:binding/sparql:uri" />
		<xsl:variable name="s" select="./sparql:binding[@name='s']" />
		<xsl:variable name="p" select="./sparql:binding[@name='p']" />
		<xsl:variable name="o" select="./sparql:binding[@name='o']" />
			
			<xsl:if test="$p = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'">
				<xsl:variable name="type" select="substring-after($o, '#')" />                                                          
				<xsl:if test="$type = 'Realization'">   
					<relationship xsi:type="Realization">
				    			
							<xsl:for-each select="//sparql:binding">
								<xsl:if test="sparql:uri[text() = $s/sparql:uri/text()]">
								<xsl:variable name="nuri" select=".//following-sibling::sparql:binding/sparql:uri/text()" />
									<!-- identifier -->
									<xsl:if test="$nuri = 'http://www.opengroup.org/xsd/archimate/3.0/#identifier'">
									<xsl:attribute name="identifier">
		    								<xsl:value-of select=".//following::sparql:binding[@name='o']/sparql:literal/text()"/>
		    							</xsl:attribute>
	  								</xsl:if>
	  								<!-- target -->
			  						<xsl:if test="$nuri = 'http://www.opengroup.org/xsd/archimate/3.0/#target'">
										<xsl:attribute name="target">
				    							<xsl:value-of select=".//following::sparql:binding[@name='o']"/>
				    						</xsl:attribute>
			  						</xsl:if>
			  						<!-- source -->
			  						<xsl:if test="$nuri = 'http://www.opengroup.org/xsd/archimate/3.0/#source'">
										<xsl:attribute name="source">
				    							<xsl:value-of select=".//following::sparql:binding[@name='o']"/>
				    						</xsl:attribute>
			  						</xsl:if>
			  					</xsl:if>
				    			</xsl:for-each>	
					</relationship>
				</xsl:if> 
			</xsl:if> 
		</xsl:template>		
			
			
			

		<xsl:template name="propertyDefinition">		
			<xsl:variable name="uri" select="sparql:binding/sparql:uri" />
			<xsl:variable name="s" select="./sparql:binding[@name='s']" />
			<xsl:variable name="p" select="./sparql:binding[@name='p']" />
			<xsl:variable name="o" select="./sparql:binding[@name='o']" />

			<xsl:if test="$p = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'">
				<xsl:variable name="type" select="substring-after($o, '#')" />
		                <xsl:if test="$type = 'PropertyDefinitionType'">                         
						<propertyDefinition type="string">	
							<xsl:for-each select="//sparql:binding">
								<!-- identifier -->
								<xsl:if test="sparql:uri[text() = $s/sparql:uri/text()]">
									<xsl:variable name="nuri" select=".//following-sibling::sparql:binding/sparql:uri/text()" />
									<xsl:if test="$nuri = 'http://www.opengroup.org/xsd/archimate/3.0/#identifier'">
									<xsl:attribute name="identifier">
		    								<xsl:value-of select=".//following::sparql:binding[@name='o']/sparql:literal/text()"/>
		    							</xsl:attribute>
	  								</xsl:if>
			  					</xsl:if>
			  					<!-- name -->
			  					<xsl:if test="sparql:uri[text() = $s/sparql:uri/text()]">
									<xsl:variable name="nuri" select=".//following-sibling::sparql:binding/sparql:uri/text()" />
									<xsl:if test="$nuri = 'http://www.opengroup.org/xsd/archimate/3.0/#name'">
									<name xml:lang="en">
		    								<xsl:value-of select=".//following::sparql:binding[@name='o']/sparql:literal/text()"/>
		    							</name>
	  								</xsl:if>
			  					</xsl:if>
				    			</xsl:for-each>	
					    	</propertyDefinition>
			    		</xsl:if>
		    		</xsl:if>					
		</xsl:template>
		
		<xsl:template name="property">
			<xsl:param name="propertyType" />		
			<property>	
				<xsl:for-each select="//sparql:result[sparql:binding[@name='s']/sparql:uri/text() = $propertyType]">
					<!-- propertyDefinitionRef -->
						<xsl:variable name="property" select="sparql:binding[@name='p']/sparql:uri/text()" />
						<xsl:if test="$property = 'http://www.opengroup.org/xsd/archimate/3.0/#propertyDefinitionRef'">
								<xsl:attribute name="propertyDefinitionRef">
									<xsl:value-of select=".//following::sparql:binding[@name='o']/sparql:literal/text()"/>
								</xsl:attribute>
						</xsl:if>
					
						<xsl:if test="$property = 'http://www.opengroup.org/xsd/archimate/3.0/#value'">
							<value>
								<xsl:value-of select="sparql:binding[@name='o']/sparql:literal/text()"/>
							</value>
						</xsl:if>
  			</xsl:for-each>	
			</property>			
		</xsl:template>
		
		<xsl:template name="properties">
			<xsl:param name="propertiesType" />		
			<xsl:for-each select="//sparql:result[sparql:binding[@name='s']/sparql:uri/text() = $propertiesType]">
				<!-- property -->
					<xsl:variable name="property" select="sparql:binding[@name='p']/sparql:uri/text()" />
					<xsl:if test="$property = 'http://www.opengroup.org/xsd/archimate/3.0/#property'">
					<xsl:call-template name="property">
						<xsl:with-param name="propertyType" select="sparql:binding[@name='o']/sparql:uri/text()" />
					</xsl:call-template>	
					</xsl:if>
    			</xsl:for-each>	
					
		</xsl:template>


</xsl:stylesheet>
