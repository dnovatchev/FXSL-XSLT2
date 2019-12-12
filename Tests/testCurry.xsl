<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myMultiply="f:myMultiply"
 exclude-result-prefixes="f myMultiply "
 >
 
 <xsl:import href="../f/curry.xsl"/>
 
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
  <myMultiply:myMultiply/>     <!-- My multiply x y function -->

  <xsl:template match="/">
    <xsl:variable name="vMyMultiply"
                  select="document('')/*/myMultiply:*[1]"/>
    
    <!-- Get the curried fn here -->
    <!-- Get the partial application (*5) -->
    <xsl:variable name="vrtfCurriedMultBy5"> 
      <xsl:call-template name="curry">
        <xsl:with-param name="pFun" select="$vMyMultiply"/>
        <xsl:with-param name="pNargs" select="2"/>
        <xsl:with-param name="arg1" select="5"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vMultBy5"
                  select="$vrtfCurriedMultBy5/*"/>


    <xsl:apply-templates select="$vMultBy5" mode="f:FXSL"> <!-- Apply (*5) on 2 -->
      <xsl:with-param name="arg2" select="2"/>
    </xsl:apply-templates> <!-- The result must be 10 -->

  </xsl:template>
  
  <xsl:template match="myMultiply:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    
    <xsl:value-of select="$arg1 * $arg2"/>
  </xsl:template>

</xsl:stylesheet>
