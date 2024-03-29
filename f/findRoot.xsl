<!--
===========================================================================
 Stylesheet: findRoot.xsl                                                  
    Version: 1.0 (2002-03-16)                                              
     Author: Dimitre Novatchev                                             
     Notice: Copyright (c)2002 D.Novatchev  ALL RIGHTS RESERVED.           
             No limitation on use - except this code may not be published, 
             in whole or in part, without prior written consent of the     
             copyright owner.                                              
===========================================================================-->
<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myIterator="f:myIterator"
 xmlns:myBSIterator="f:myBSIterator" 
 xmlns:fxslFRBS-Cond="f:fxslFRBS-Cond"
 xmlns:x="f:x-findRoot.xsl"
 exclude-result-prefixes="f xs x myIterator myBSIterator fxslFRBS-Cond"
 >
<!--
  ==========================================================================
    Imported files:                                                         
  ==========================================================================-->
  <xsl:import href="within.xsl"/>
  <xsl:import href="iter.xsl"/>

  <xsl:variable name="x:st" select="document('')/*"/>
  
<!--
      Template: findRootNR                                                   
      Purpose : Return the root of an equation f(X) = 0,                     
                using the Newton-Raphston method                             
    Parameters:                                                              
    $pFun     - a template reference for the function f(X),                  
                whose root is to be found                                    
    $pFunPrim - a template reference for the derivative of                   
                the function f(X)  (f'(X))                                   
    $pX0      - a starting element for the sequence to be produced.          
                it must be within the domain of f(X)                         
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
  <xsl:template name="findRootNR">
    <xsl:param name="pFun" select="/.."/>
    <xsl:param name="pFunPrim" select="/.."/>
    <xsl:param name="pX0"/>
    <xsl:param name="pEps" select="0.1"/>
    
<!--    <xsl:variable name="vIterator" select="$x:st/myIterator:*[1]"/>-->
    
    <xsl:variable name="vIterator" as="element()">
      <myIterator:myIterator/>
    </xsl:variable>
    
    <xsl:variable name="vrtfParams">
      <param><xsl:value-of select="$pX0"/></param>
      <xsl:copy-of select="$pFun"/>
      <xsl:copy-of select="$pFunPrim"/>
    </xsl:variable>

    <xsl:call-template name="within">
      <xsl:with-param name="pGenerator" select="$vIterator"/>
      <xsl:with-param name="pParam0" select="$vrtfParams/*"/>
	    <xsl:with-param name="Eps" select="$pEps"/>
    </xsl:call-template>
  </xsl:template>


<!--
      Template: findRootBS                                                   
      Purpose : Return the root of an equation f(X) = 0,                     
                using the Binary - Search method                             
    Parameters:                                                              
    $pFun     - a template reference for the function f(X),                  
                whose root is to be found. The function must be              
                monotonic on the interval [pX1, pX2]                         
    $pX1      - the start of the interval, in which                          
                the root is to be found.                                     
    $pX2      - the end of the interval, in which                            
                the root is to be found.                                     
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
  <xsl:template name="findRootBS">
    <xsl:param name="pFun" select="/.."/>
    <xsl:param name="pX1"/>
    <xsl:param name="pX2"/>
    <xsl:param name="pEps" select="0.1"/>
    
    <xsl:variable name="vIterator" select="$x:st/myBSIterator:*[1]"/>
    
    <xsl:variable name="vFX1">
      <xsl:apply-templates select="$pFun" mode="f:FXSL">
        <xsl:with-param name="arg1" select="$pX1"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:variable name="vFX2">
      <xsl:apply-templates select="$pFun" mode="f:FXSL">
        <xsl:with-param name="arg1" select="$pX2"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$vFX1 = 0">
        <xsl:value-of select="$pX1"/>
      </xsl:when>
      <xsl:when test="$vFX2 = 0">
        <xsl:value-of select="$pX2"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$vFX1 * $vFX2 > 0">
          <xsl:message terminate="yes">
            <xsl:value-of select="concat('f(x1) = ', $vFX1,
                                    ' and f(x2) = ', $vFX2,
                                    ' must have different signs!')"/>
          </xsl:message>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:variable name="vrtf-X-Iter">
      <X1><xsl:value-of select="$pX1"/></X1>
      <FX1><xsl:value-of select="$vFX1"/></FX1>
      <X2><xsl:value-of select="$pX2"/></X2>
      <FX2><xsl:value-of select="$vFX2"/></FX2>
      <Eps><xsl:value-of select="$pEps"/></Eps>
      <xsl:copy-of select="$pFun"/>
    </xsl:variable>


    <xsl:variable name="rtftheRoot">
	    <xsl:call-template name="iterUntil">
	      <xsl:with-param name="pFun" select="$vIterator"/>
	      <xsl:with-param name="pCond" select="$x:st/fxslFRBS-Cond:*[1]"/>
		    <xsl:with-param name="arg1" select="$vrtf-X-Iter"/>
	    </xsl:call-template>
    </xsl:variable>
    
    <xsl:value-of select="$rtftheRoot/X1"/>
  </xsl:template>
  
  <xsl:template match="myIterator:*" mode="f:FXSL">
    <xsl:param name="pList" select="/.."/>
    <xsl:param name="pParams"/>
  
     <xsl:choose>
	     <xsl:when test="empty($pList)">
	        <xsl:copy-of select="$pParams[1]/node()"/>
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:variable name="vXn" select="$pList[last()]"/>
	       
	       <xsl:variable name="vF-Xn">
		       <xsl:apply-templates select="$pParams[2]" mode="f:FXSL">
		         <xsl:with-param name="arg1" select="$vXn"/>
		       </xsl:apply-templates>
	       </xsl:variable>
	       
	       <xsl:variable name="vFPrim-Xn">
		       <xsl:apply-templates select="$pParams[3]" mode="f:FXSL">
		         <xsl:with-param name="arg1" select="$vXn"/>
		       </xsl:apply-templates>
	       </xsl:variable>
	       
	       <xsl:value-of select="$vXn - $vF-Xn div $vFPrim-Xn"/>
	     </xsl:otherwise>
     </xsl:choose>
  </xsl:template>
  
  <xsl:template match="myBSIterator:*" mode="f:FXSL">
    <xsl:param name="arg1" as="document-node()"/>
    
    <xsl:variable name="vX1" select="number($arg1/X1)"/>
    <xsl:variable name="vX2" select="number($arg1/X2)"/>
    <xsl:variable name="vFX1" select="number($arg1/FX1)"/>
    <xsl:variable name="vFX2" select="number($arg1/FX2)"/>
    <xsl:variable name="vEps" select="number($arg1/Eps)"/>
    <xsl:variable name="vFun" select="$arg1/*[last()]"/>

    <xsl:variable name="vMid" as="xs:double" select="($vX1 + $vX2) div 2"/>
    
    <xsl:variable name="vFMid">
      <xsl:apply-templates select="$vFun" mode="f:FXSL">
        <xsl:with-param name="arg1" select="$vMid"/>
      </xsl:apply-templates>
    </xsl:variable>

		 <xsl:document>
			  <X1><xsl:value-of select="$vMid"/></X1>
			  <FX1><xsl:value-of select="$vFMid"/></FX1>
			    <xsl:choose>
				    <xsl:when test="$vFMid > 0 and $vFX1 > 0 
				                 or ($vFMid &lt; 0 and $vFX1 &lt; 0)">
				                 
						      <X2><xsl:value-of select="$vX2"/></X2>
						      <FX2><xsl:value-of select="$vFX2"/></FX2>
				    </xsl:when>
				    <xsl:otherwise>
				      <X2><xsl:value-of select="$vX1"/></X2>
				      <FX2><xsl:value-of select="$vFX1"/></FX2>
				    </xsl:otherwise>
			    </xsl:choose>
			  <xsl:copy-of select="$arg1/Eps"/> <!-- <Eps> -->
			  <xsl:copy-of select="$vFun"/>
		 </xsl:document>   
  </xsl:template>
  
  <xsl:template match="fxslFRBS-Cond:*" mode="f:FXSL">
    <xsl:param name="arg1" as="document-node()"/>

    <xsl:variable name="vEps" as="xs:double" select="$arg1/Eps"/>
    <xsl:variable name="vResult"  as="xs:double"  select="$arg1/FX1"/>

		<xsl:sequence select=
		   "if( ($vResult &lt;= $vEps) and (-$vEps &lt;= $vResult) )
		      then 1
		      else 0    
		   "/>
		   
  </xsl:template>
  
  <!-- ************************************************************* -->
  <!-- ********************* INTERNAL USE ONLY ********************* -->
  <!-- ************************************************************* -->
  <!-- defined constants -->
<!--
    A node matched by the template that implements the iterating function    
    for Newton - Raphston
 -->
  <myIterator:myIterator/>
<!--
    A node matched by the template that implements the iterating function    
    for Binary Search
 -->  
 <myBSIterator:myBSIterator/>
  
<!--
    A node matched by the template that evaluates the stop condition
    of the iterating function for Binary Search
 -->  
 <fxslFRBS-Cond:fxslFRBS-Cond/>
  
</xsl:stylesheet>