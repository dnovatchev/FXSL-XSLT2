<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:myHalve="myHalve" 
xmlns:myTenXController="myTenXController" 
xmlns:myEasyDiffMap="myEasyDiffMap"
xmlns:myWithinController="myWithinController" 
xmlns:myFunction="myFunction" 
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f myHalve myTenXController
 myEasyDiffMap myFunction myWithinController"
>
  <xsl:import href="../f/buildListWhileMap.xsl"/>

  <!-- To be applied on any xml. This produces the derivative of
       x^2 for x = 6, with precision 0.00001
   -->
   
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <myHalve:myHalve/>
  <myWithinController:myWithinController/>
  <myTenXController:myTenXController/>
  <myEasyDiffMap:myEasyDiffMap/>
  <myFunction:myFunction/>
  
  <xsl:variable name="vMyHalveGenerator" select="document('')/*/myHalve:*[1]"/>
  <xsl:variable name="vmyWithinController" select="document('')/*/myWithinController:*[1]"/>
  <xsl:variable name="vmyEasyDiffMap" select="document('')/*/myEasyDiffMap:*[1]"/>
  <xsl:variable name="vmyFunction" select="document('')/*/myFunction:*[1]"/>
  
  <xsl:template match="/">
    <xsl:variable name="fx">
      <xsl:apply-templates select="$vmyFunction" mode="f:FXSL">
        <xsl:with-param name="pParam" select="6"/>
      </xsl:apply-templates>
    </xsl:variable>
    
    <xsl:variable name="vrtfMapParams">
     <xsl:copy-of select="$vmyFunction"/>
     <param>6</param>
     <param><xsl:value-of select="$fx"/></param>
    </xsl:variable>
    
    <xsl:variable name="vMapParams" select="$vrtfMapParams/*"/>
    
    <xsl:call-template name="buildListWhileMap">
	    <xsl:with-param name="pGenerator" select="$vMyHalveGenerator"/>
	    <xsl:with-param name="pParam0" select="0.1"/>
	    <xsl:with-param name="pController" select="$vmyWithinController"/>
	    <xsl:with-param name="pContollerParam" select="0.00001"/>
	    <xsl:with-param name="pMap" select="$vmyEasyDiffMap"/>
	    <xsl:with-param name="pMapParams" select="$vMapParams"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="myHalveGenerator" 
                match="*[namespace-uri()='myHalve']" 
                mode="f:FXSL">
     <xsl:param name="pParams" select="/.."/>
     <xsl:param name="pList" select="/.."/>
     
     <xsl:choose>
       <xsl:when test="not($pList)"><xsl:value-of select="$pParams"/></xsl:when>
       <xsl:otherwise><xsl:value-of select="$pList[last()] div 2"/></xsl:otherwise>
     </xsl:choose>
  </xsl:template>

  <xsl:template name="myWithinController" 
                match="*[namespace-uri()='myWithinController']"
                mode="f:FXSL">
     <xsl:param name="pParams" select="/.."/>
     <xsl:param name="pList" select="/.."/>
     
     <xsl:variable name="vLastDiff" select="$pList[last()] - $pList[last() - 1]"/>
     
     
     <xsl:choose>
       <xsl:when test="not($vLastDiff &lt; $pParams 
                      and $vLastDiff > (0 - $pParams))
                      ">1</xsl:when>
     </xsl:choose>
  </xsl:template>

  <xsl:template name="myEasyDiffMap" 
                match="*[namespace-uri()='myEasyDiffMap']"
                mode="f:FXSL">
     <xsl:param name="pParams" select="/.."/>
     <xsl:param name="pDynParams" select="/.."/>
     <xsl:param name="pList" select="/.."/>
     
     <xsl:variable name="x" select="$pParams[2]"/>
     <xsl:variable name="h" select="$pDynParams[1]"/>
     
     
     <xsl:choose>
	     <xsl:when test="not($h = 0)">
		     <xsl:variable name="fx_plus_h">
			     <xsl:apply-templates select="$pParams[1]"  mode="f:FXSL">
			       <xsl:with-param name="pParam" select="$x + $h"/>
			     </xsl:apply-templates>
		     </xsl:variable>
		     
		     <xsl:variable name="fx">
		         <xsl:choose>
			         <xsl:when test="count($pParams) >= 3">
			           <xsl:value-of select="$pParams[3]"/>
			         </xsl:when>
			         <xsl:otherwise>
					     <xsl:apply-templates select="$pParams[1]"  mode="f:FXSL">
					       <xsl:with-param name="pParam" select="$x"/>
					     </xsl:apply-templates>
				     </xsl:otherwise>
			     </xsl:choose>
		     </xsl:variable>
		     
		     <xsl:value-of select="($fx_plus_h - $fx) div $h"/>
	     </xsl:when>
	     <xsl:otherwise><xsl:value-of select="$pList[last()]"/></xsl:otherwise>
     </xsl:choose>
  </xsl:template>

  <xsl:template name="myFunction" match="*[namespace-uri()='myFunction']"
   mode="f:FXSL">
     <xsl:param name="pParam" select="/.."/>
     
     <xsl:value-of select="$pParam * $pParam"/>
  </xsl:template>

</xsl:stylesheet>
