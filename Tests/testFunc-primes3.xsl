<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f" 
>
  <xsl:import href="../f/func-Primes3.xsl"/>

 <xsl:output method="text"/>
 
<!--
    Solves the following problem:
    
    Find the first 10-digit prime in consecutive digits of e
    
    See e.g:
    http://www.google.com/googleblog/2004/07/warning-we-brake-for-number-theory.html

   Invoke on any xml file or with an initial template named "initial".

   Expected result: 7427466391
-->
 
 <xsl:variable name="vE" select=
 "concat('2.71828182845904523536',
         '02874713526624977572470',
         '93699959574966967627724',
         '07663035354759457138217',
         '85251664274274663919320',
         '03059921817413596629043',
         '57290033429526059563073',
         '81323286279434907632338',
         '29880753195251019011573',
         '83418793070215408914993',
         '48841675092447614606680',
         '82264800168477411853742',
         '34544243710753907774499',
         '20695517027618'
 )"/>
 
  <xsl:template name="initial" match="/*">

    <xsl:variable name="vPortions" 
    select="for $n in 3 to string-length($vE)-9
                    return(xs:integer(substring($vE, $n, 10)))
           "/>

   <xsl:value-of select="f:firstPrime($vPortions, (2,3,5,7,11))"/> 
  </xsl:template>
  
  <xsl:function name="f:firstPrime" as="xs:integer?">
    <xsl:param name="pnSeq" as="xs:integer*"/>
    <xsl:param name="pknownPrimes" as="xs:integer+"/>
    
    <xsl:if test="exists($pnSeq)">
      <xsl:variable name="vResults" as="xs:integer+"
       select="f:isPrime($pnSeq[1], $pknownPrimes)"/>
       
       <xsl:value-of select=
         "if($vResults[1])
            then 
              $pnSeq[1]
            else
              f:firstPrime($pnSeq[position() gt 1], $vResults[position() gt 1])
         "/>
     </xsl:if>
  </xsl:function>

</xsl:stylesheet>
