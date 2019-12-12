<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:myDistribution="f:myDistribution"
 exclude-result-prefixes="xs myDistribution"
>

  <xsl:import href="../f/random.xsl"/>
  
  <myDistribution:myDistribution>
    <o>1</o><p>0.2</p>
    <o>2</o><p>0.25</p>
    <o>3</o><p>0.25</p>
    <o>4</o><p>0.15</p>
    <o>5</o><p>0.1</p>
    <o>6</o><p>0.05</p>
  </myDistribution:myDistribution>
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:variable name="NL" select="'&#xA;'"/>
  
  <xsl:template match="/">
    
    <xsl:variable name="vrtfUnscaledRandoms">
  	  <xsl:call-template name="randomSequence">
  	    <xsl:with-param name="pLength" select="100"/>
  	  </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vUnscaledRandoms" 
     select="$vrtfUnscaledRandoms/*"/>
     
100 Randoms in (0,<xsl:value-of select="$modulus - 1"/>):
    <xsl:for-each select="$vUnscaledRandoms
                             [position() mod 8 = 1]">
      <xsl:value-of select="$NL"/>
      <xsl:for-each 
         select=". | following::*[position() &lt; 8]">
        <xsl:value-of select="concat(., ', ')"/>
      </xsl:for-each>
    </xsl:for-each>
    
    <xsl:variable name="vStart" as="xs:double" select="1.0E0"/>
    <xsl:variable name="vEnd" as="xs:double" select="10.0E0"/>
    
    <xsl:value-of select="concat($NL,$NL,
                                 '100 Randoms in (',
                                 string($vStart), ', ',
                                 string($vEnd), '):',
                                 $NL
                                 )"/> 
    <xsl:variable name="vrtfScaledRandoms">
	  <xsl:call-template name="randomSequence">
	    <xsl:with-param name="pLength" select="100"/>
	    <xsl:with-param name="pStart" select="$vStart"/>
	    <xsl:with-param name="pEnd" select="$vEnd"/>
	  </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vScaledRandoms" 
       select="$vrtfScaledRandoms/*"/>
    
    <xsl:for-each select="$vScaledRandoms
                              [position() mod 10 = 1]">
      <xsl:value-of select="$NL"/>
      <xsl:for-each 
         select=". | following::*[position() &lt; 10]">
        <xsl:value-of select="concat(., ', ')"/>
      </xsl:for-each>
    </xsl:for-each>
    
    <xsl:value-of select="concat($NL,$NL,
                                 'Randoms 11-20 in (',
                                 string($vStart), ', ',
                                 string($vEnd), '):',
                                 $NL
                                 )"/> 
    <xsl:variable name="vrtfRandSubsequence">
      <xsl:call-template name="randomSubSequence">
        <xsl:with-param name="pLength" select="10"/>
        <xsl:with-param name="pSubStart" select="11"/>
        <xsl:with-param name="pStart" select="$vStart"/>
	      <xsl:with-param name="pEnd" select="$vEnd"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:copy-of 
      select="$vrtfRandSubsequence/*"/>
    
    <xsl:variable name="vrtfDistRandSeq">
      <xsl:call-template name="dist-randomSequence">
        <xsl:with-param name="pLength" select="100"/>
        <xsl:with-param name="pDist" 
         select="document('')/*/myDistribution:*[1]/*"/>
        
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:value-of select="concat($NL,$NL,
      '100 Random outcomes 1-6 with distribution:&#xA;'
                                 )"/> 
    <xsl:copy-of 
         select="document('')/*/myDistribution:*[1]"/>
    <xsl:value-of 
          select="concat($NL, $NL, 'Results:', $NL)"/>
    
    <xsl:variable name="vDistRandSeq" 
         select="$vrtfDistRandSeq/*"/>
    
    <xsl:for-each select="$vDistRandSeq
                              [position() mod 10 = 1]">
      <xsl:value-of select="$NL"/>
      <xsl:for-each 
         select=". | following::*[position() &lt; 10]">
        <xsl:value-of select="concat(., ', ')"/>
      </xsl:for-each>
    </xsl:for-each>
    
        <xsl:value-of select="concat($NL,$NL,
           'Randoms 11-20 with the same distribution:',
                                 $NL
                                 )"/> 
    <xsl:variable name="vrtfDistRandSubsequence">
      <xsl:call-template name="dist-randomSubSequence">
        <xsl:with-param name="pLength" select="10"/>
        <xsl:with-param name="pSubStart" select="11"/>
        <xsl:with-param name="pDist" 
         select="document('')/*/myDistribution:*[1]/*"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:copy-of 
    select="$vrtfDistRandSubsequence/*"/>
  </xsl:template>
</xsl:stylesheet>
