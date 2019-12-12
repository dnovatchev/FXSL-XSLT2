<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:pGenerator="pGenerator"
xmlns:pController="pController"
xmlns:IntervalParams="IntervalParams"
xmlns:IntegralFunction="IntegralFunction"
exclude-result-prefixes="f pGenerator pController IntervalParams IntegralFunction"
>
  <!-- <xsl:import href="buildListWhile.xsl"/> -->
  <xsl:import href="../f/buildListWhileMap.xsl"/> 
  
   <!-- to be applied on any xml source -->
   
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <pGenerator:pGenerator/>
  <pController:pController/>

  <IntervalParams:IntervalParams>
    <Interval>
	    <el>0</el>
	    <el>1</el>
    </Interval>
    <IntegralFunction:IntegralFunction/>
  </IntervalParams:IntervalParams>
  
  <xsl:variable name="vMyGenerator" select="document('')/*/pGenerator:*[1]"/>
  <xsl:variable name="vMyController" select="document('')/*/pController:*[1]"/>
  <xsl:variable name="vIntervalParams" select="document('')/*/IntervalParams:*[1]"/>

  <xsl:template match="/">
    <xsl:variable name="vrtfResultIntervalList">
      <xsl:call-template name="buildListWhileMap">
        <xsl:with-param name="pGenerator" select="$vMyGenerator"/>
        <xsl:with-param name="pController" select="$vMyController"/>
        <xsl:with-param name="pParam0" select="$vIntervalParams"/>
        <xsl:with-param name="pContollerParam" select="256"/>
	  </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vResultIntervalList"
       select="$vrtfResultIntervalList/*[last()]/*"/>
       
    <xsl:for-each select="$vResultIntervalList">
     <xsl:copy-of select="."/>
    </xsl:for-each>
    
  </xsl:template>

  <xsl:template name="listGenerator" match="*[namespace-uri()='pGenerator']"
  mode="f:FXSL"
>
     <xsl:param name="pList" select="/.."/>
     <xsl:param name="pParams"/>

     <xsl:variable name="pA0" select="string($pParams/*[1]/*[1])"/>
     <xsl:variable name="pB0" select="string($pParams/*[1]/*[2])"/>
     <xsl:variable name="pFun" select="$pParams/*[2]"/>
     
     <xsl:choose>
       <xsl:when test="not($pList)">
         <xsl:variable name="vFa">
           <xsl:apply-templates select="$pFun"  mode="f:FXSL">
             <xsl:with-param name="pX" select="$pA0"/>
           </xsl:apply-templates>
         </xsl:variable>
       
         <xsl:variable name="vFb">
           <xsl:apply-templates select="$pFun"  mode="f:FXSL">
             <xsl:with-param name="pX" select="$pB0"/>
           </xsl:apply-templates>
         </xsl:variable>
         
         <e><xsl:value-of select="number($pB0) - number($pA0)"/></e>
         <e><xsl:value-of select="$vFa"/></e>
         <e><xsl:value-of select="$vFb"/></e>
       </xsl:when>
       <xsl:otherwise>
          <xsl:variable name="vprevH" select="$pList[last()]/*[1]"/>
          <xsl:variable name="vH" select="$vprevH div 2"/>
          <e><xsl:value-of select="$vH"/></e>
          <xsl:for-each select="$pList[last()]/*[position() > 1 
                                             and position() != last()]">
           <xsl:variable name="vA" select="number($pA0) + (position() - 1) * $vprevH"/>
           
           <xsl:variable name="vMid" select="number($vA) + number($vH)"/>
           
           <xsl:variable name="vF_mid">
             <xsl:apply-templates select="$pFun"  mode="f:FXSL">
               <xsl:with-param name="pX" select="$vMid"/>
             </xsl:apply-templates>
           </xsl:variable>
           
           
           
           <xsl:copy-of select="."/>
           <e><xsl:value-of select="$vF_mid"/></e>
         </xsl:for-each>
         <xsl:copy-of select="$pList[last()]/*[last()]"/>
       </xsl:otherwise>
     </xsl:choose>
     
  </xsl:template>

  <xsl:template name="listController" match="*[namespace-uri()='pController']"
   mode="f:FXSL">
     <xsl:param name="pList" select="/.."/>
     <xsl:param name="pParams"/>

     <xsl:if test="count($pList[last()]/*) &lt;= $pParams">1</xsl:if>
  </xsl:template>
  
  <xsl:template name="myIntegralFn" match="*[namespace-uri()='IntegralFunction']"
   mode="f:FXSL">
    <xsl:param name="pX"/>
    
    <xsl:value-of select="$pX"/>
  </xsl:template>
     
</xsl:stylesheet>