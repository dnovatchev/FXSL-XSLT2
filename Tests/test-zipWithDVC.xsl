<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myAdd="f:myAdd"
 exclude-result-prefixes="f myAdd"
>
  <xsl:import href="../f/zipWithDVC.xsl"/>
  <!-- To be applied on numList.xml -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  <myAdd:myAdd/>
  <xsl:template match="/">
    <xsl:variable name="vFun" select="document('')/*/myAdd:*[1]"/>

    <xsl:call-template name="zipWith">
      <xsl:with-param name="pFun" select="$vFun"/>
      <xsl:with-param name="pList1" select="(/*/*)[position() &lt; 6]"/>
      <xsl:with-param name="pList2" select="(/*/*)[position() > 5]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="myAdd:*" mode="f:FXSL">
    <xsl:param name="pArg1"/>
    <xsl:param name="pArg2"/>

    <xsl:value-of select="$pArg1 + $pArg2"/>
  </xsl:template>

</xsl:stylesheet>
