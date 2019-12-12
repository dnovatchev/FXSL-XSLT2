<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myAdd3="f:myAdd3"
 exclude-result-prefixes="f myAdd3"
>
  <xsl:import href="../f/func-zipWith3.xsl"/>
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  <!-- To be applied on numList.xml -->

  <xsl:template match="/">
    <xsl:variable name="vFun" select="document('')/*/myAdd3:*[1]"/>

    <xsl:for-each select=
     "f:zipWith3($vFun, 
                 (/*/*)[position() &lt; 4],
                 (/*/*)[position() >= 4
                      and position() &lt; 7],
                 (/*/*)[position() >= 7]
                 )">
        <xsl:value-of select="concat(.,',')"/>
     </xsl:for-each>
  </xsl:template>

  <myAdd3:myAdd3/>
  <xsl:template match="myAdd3:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>

    <xsl:value-of select="$arg1 + $arg2 + $arg3"/>
  </xsl:template>

</xsl:stylesheet>