<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
   <xsl:import href="../f/identity.xsl"/>
   <xsl:import href="../f/func-maxDepth.xsl"/>
   
   <xsl:output omit-xml-declaration="yes"/>
   <xsl:strip-space elements="*"/>
   
   <!-- This transformation must be applied to:
        ../data/testMaximum3.xml 

        Expected result: <root>
	                   <folder name="5">
			     <folder name="6">
			       <folder name="7">
			         <folder name="8"/>
			       </folder>
			     </folder>
			   </folder>
			   <folder name="1">
			     <folder name="3">
			       <folder name="4"/>
			     </folder>
			     <folder name="2"/>
			   </folder>
			 </root>
    -->
    
    <xsl:template match="*[folder]">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="folder">
          <xsl:sort select="f:maxDepth(.)" data-type="number"
           order="descending"/>
        </xsl:apply-templates>
        
      </xsl:copy>
    </xsl:template>

</xsl:stylesheet>