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
  				<xsl:for-each select="sparql:result">
	  				<xsl:call-template name="result"/>
		    		</xsl:for-each>
			  	</elements>
			</model>
		</xsl:template>	

		<xsl:template name="result">
			<xsl:variable name="uri" select="sparql:binding/sparql:uri" />
			<xsl:variable name="s" select="./sparql:binding[@name='s']" />
			<xsl:variable name="p" select="./sparql:binding[@name='p']" />
			<xsl:variable name="o" select="./sparql:binding[@name='o']" />
			<xsl:variable name="label" select="substring-after($s, '_')" />
			<xsl:variable name="type" select="substring-before($label, '_')" />
<xsl:message><xsl:value-of select="$type"/></xsl:message>
			<xsl:if test="$uri/text() = 'http://www.opengroup.org/xsd/archimate/3.0/#identifier' and $type != 'model' and $type != 'PropertyDefinitionType'">
			
			<element>
					<xsl:attribute name="identifier">
		    				<xsl:value-of select="./sparql:binding[@name='o']"/>
		    			</xsl:attribute>
					<xsl:for-each select="//sparql:binding">
						<xsl:if test="sparql:uri[text() = $s/sparql:uri/text()]">
							<xsl:variable name="xsitype" select=".//following-sibling::sparql:binding//following-sibling::sparql:binding/sparql:uri/text()" />
	  						<xsl:if test=".//following-sibling::sparql:binding/sparql:uri[text() = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type']">
								<xsl:attribute name="xsi:type">
		    							<xsl:value-of select="substring-after($xsitype, '#')"/>
		    						</xsl:attribute>
	  						</xsl:if>
	  					</xsl:if>
		    			</xsl:for-each>	
		    		<name xml:lang="en">
		    		<xsl:value-of select="$label"/>
		    		</name>
		    	</element>
		    	</xsl:if>
		</xsl:template>
</xsl:stylesheet>
