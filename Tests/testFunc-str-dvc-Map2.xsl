<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
xmlns:testmap="testmap"
exclude-result-prefixes="xs f testmap"
>
   <xsl:import href="../f/func-str-dvc-map.xsl"/>
   
   <!-- To be applied on numList.xml -->
   
   <testmap:testmap/>
   
   <xsl:variable name="vLF" select="'&#10;'"/>

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
   <xsl:template match="/">
     <xsl:variable name="vTestMap" select="document('')/*/testmap:*[1]"/>
     <xsl:copy-of select="f:str-map($vTestMap, string(/*))"/>
   </xsl:template>

    <xsl:template name="indentNL" match="*[namespace-uri() = 'testmap']"
     mode="f:FXSL">
      <xsl:param name="arg1" as="xs:string"/>
      
      <xsl:value-of select=
      "if($arg1 = $vLF)
            then concat($arg1, '    ')
            else
               $arg1
      "
      />
    </xsl:template>

</xsl:stylesheet>