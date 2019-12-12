<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

   <xsl:import href="../f/strSplit-to-Words.xsl"/>
<!-- This transformation must be applied to:
       words.xml                            
-->

   <xsl:output indent="yes" omit-xml-declaration="yes"/>
   
    <xsl:template match="/">
      <xsl:variable name="vwordNodes">
        <xsl:call-template name="str-split-to-words">
          <xsl:with-param name="pStr" select="/"/>
          <xsl:with-param name="pDelimiters" 
                          select="', &#9;&#10;&#13;'"/>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:apply-templates select="$vwordNodes/*"/>
    </xsl:template>
    
    <xsl:template match="word">
      <xsl:value-of select="concat(string(position()), ' ', ., '&#10;')"/>
    </xsl:template>

</xsl:stylesheet>
