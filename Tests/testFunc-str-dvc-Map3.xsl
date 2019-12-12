<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:testmap="testmap"
exclude-result-prefixes="f testmap"
>
   <xsl:import href="../f/func-str-dvc-map.xsl"/>
   
   <xsl:variable name="vCaps" select=
   "'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

   <!-- to be applied on any xml source -->
   
   <xsl:variable name="vTestMap" as="element()"> 
     <testmap:testmap/>
   </xsl:variable>
   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
   <xsl:template match="/">
     
     <xsl:value-of select="f:str-map($vTestMap, 'DocumentLogicalType')"/>
   </xsl:template>

    <xsl:template name="double" match="testmap:*"
     mode="f:FXSL">
      <xsl:param name="arg1"/>
      
      <xsl:value-of select=
       "concat(if(contains($vCaps, $arg1)) then ' ' else '', $arg1)"
       />
    </xsl:template>

</xsl:stylesheet>