<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:mySquare="f:mySquare" 
 xmlns:myDouble="f:myDouble"
 exclude-result-prefixes="f mySquare myDouble"
 >
  
  <xsl:import href="../f/randomList.xsl"/>
  
  <!-- Can be applied on any source xml document (ignored) -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  <mySquare:mySquare/>
  <myDouble:myDouble/>
  
  <xsl:template match="/">
  
    <xsl:variable name="vrtfRands">
      <xsl:call-template name="randomSequence">
        <xsl:with-param name="pLength" select="100"/>
      </xsl:call-template>
    </xsl:variable>
    
    Random Recursive Index (dScale (randomSequence 100)):
    
    <xsl:call-template name="_dScale">
      <xsl:with-param name="pRandSeq" 
          select="$vrtfRands/*"/>
    </xsl:call-template>
    
    Random Recursive Index 10:
    
    <xsl:variable name="vrtfRecIndex">
      <xsl:call-template name="_randomRecursiveIndex">
        <xsl:with-param name="pList" 
        select="1  to 10"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vRecIndex" 
              select="$vrtfRecIndex/*"/>
              
    <xsl:for-each select="$vRecIndex">
      <xsl:copy-of select="."/>&#xA;
    </xsl:for-each>
    
    Randomized 10-elements list:
    <xsl:call-template name="_permutationFromRecursiveIndex">
      <xsl:with-param name="pList" select="1  to 10"/>
      <xsl:with-param name="pRecIndex" select="$vRecIndex"/>
    </xsl:call-template>
    
    RandomizeList:
    <xsl:call-template name="randomizeList">
      <xsl:with-param name="pList" select="1  to 10"/>
    </xsl:call-template>
    
    <xsl:variable name="vFunSquare" 
         select="document('')/*/mySquare:*[1]"/>
    
    _mapFromRandIndex (^2) [1..10] seed:
    <xsl:call-template name="_mapFromRandIndex">
      <xsl:with-param name="pFun" select="$vFunSquare"/>
      <xsl:with-param name="pList" select="1  to 10"/>
      <xsl:with-param name="pRecIndex" select="$vRecIndex"/>
    </xsl:call-template>
    
    <xsl:variable name="vFunDouble" 
         select="document('')/*/myDouble:*[1]"/>
    
    randomMap (*2) [1..10] seed:
    <xsl:call-template name="randomMap">
      <xsl:with-param name="pFun" select="$vFunDouble"/>
      <xsl:with-param name="pList" select="1  to 10"/>
    </xsl:call-template>
    
    randListIndex [1..10] seed:
    <xsl:call-template name="randListIndex">
      <xsl:with-param name="pList" select="1  to 10"/>
    </xsl:call-template>
    
  </xsl:template>
  
  <xsl:template match="mySquare:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:value-of select="$arg1 * $arg1"/>
  </xsl:template>

  <xsl:template match="myDouble:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:value-of select="$arg1 + $arg1"/>
  </xsl:template>
</xsl:stylesheet>