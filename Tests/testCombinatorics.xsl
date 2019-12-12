<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 exclude-result-prefixes="xsl"
 >

<!--
  ==========================================================================
    Imported files:                                                         
  ==========================================================================-->

  <xsl:import href="../f/combinatorics.xsl"/>
 <!-- This transformation must be applied to:
        testCombinatorics.xml                
-->  
  
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
  <xsl:template match="/">
      <test>
		    <xsl:call-template name="cartProduct">
		      <xsl:with-param name="pLists" select="/test1/*"/>
		    </xsl:call-template>
     </test>
	  </xsl:template>
</xsl:stylesheet>
