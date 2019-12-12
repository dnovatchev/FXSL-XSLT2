<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:testmap="f:testmap"
exclude-result-prefixes="f xs testmap"
>
   <xsl:import href="../f/func-str-map.xsl"/>

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   <!-- to be applied on any xml source -->
  
   <xsl:variable name="vFunMap" as="element()">
	   <testmap:testmap/>
   </xsl:variable>  
   
   <xsl:template match="/">
     <xsl:sequence select="f:str-map($vFunMap, 'YYYYNYY')"/>
   </xsl:template>

    <xsl:template name="wrapChars" match="testmap:*"
     mode="f:FXSL">
      <xsl:param name="arg1"/>
      
			<TD>
			  <xsl:if test="$arg1 = 'Y'">
			    <xsl:attribute name="color">green</xsl:attribute>
			  </xsl:if>
			  <xsl:text>S</xsl:text>
			</TD>
    </xsl:template>

</xsl:stylesheet>