<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:gexslt="http://www.gobosoft.com/eiffel/gobo/gexslt/extension"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs saxon f" 
 >
  <xsl:import href="../Tests/Problems/primesLT50M.xsl"/>
  <xsl:import href="func-binSearch.xsl"/>
  <xsl:import href="func-sqrt.xsl"/>

 <xsl:output method="text"/>

  <xsl:variable name="vthePrimes" as="xs:integer+"
   select="$vPrimesLT50M"/>
   
   <xsl:variable name="vthePrimesCount" as="xs:integer"
   select="$vcountPrimesLT50M"/>

   <xsl:variable name="vtheMaxPrime" as="xs:integer"
   select="$vthePrimes[$vcountPrimesLT50M]"/>


  <xsl:function name="f:isPrime" as="xs:boolean" saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pNum" />
    
    <xsl:variable name="vstrNum" select="string($pNum)" as="xs:string"/>
    <xsl:variable name="vLastDigit" 
                  select="substring($vstrNum, string-length($vstrNum))"/>
                  
    <xsl:value-of select=
           "if($pNum gt 9 and not(translate($vLastDigit, '024568', '')) )
               then false()
               else
                 if($pNum le 50000000)
                   then
                     f:binSearch($vthePrimes, 
                                    $pNum, 
                                    1, 
                                    $vcountPrimesLT50M
                                    )
	                   else
	                    if(f:pow2mod($pNum -1, $pNum) ne 1)
	                       then false()
	                       else
					                empty(
					                   (2, 3, 7, 5, 11, 13, 17, 19, 23, 29, 31, 37, 41,
					                     (43 to xs:integer(round(f:sqrt($pNum, 0.1E0)))) )
			                               [$pNum mod . = 0]
					                       )
            "/>
  </xsl:function>

  <xsl:function name="f:isPrimePseudo" as="xs:boolean" saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pNum" />
    
    <xsl:variable name="vstrNum" select="string($pNum)" as="xs:string"/>
    <xsl:variable name="vLastDigit" 
                  select="substring($vstrNum, string-length($vstrNum))"/>
                  
    <xsl:value-of select=
           "if($pNum gt 9 and not(translate($vLastDigit, '024568', '')) )
               then false()
               else
                 if($pNum le 50000000)
                   then
                     f:binSearch($vthePrimes, 
                                    $pNum, 
                                    1, 
                                    $vcountPrimesLT50M
                                    )
	                   else
	                    if(f:pow2mod($pNum -1, $pNum) ne 1)
	                       then false()
	                       else
					                true()
            "/>
  </xsl:function>

<!--
    f:pow2mod(K, N) = 2^K mod N
-->  
  <xsl:function name="f:pow2mod" as="xs:decimal">
    <xsl:param name="pE" as="xs:decimal"/>
    <xsl:param name="pN" as="xs:decimal"/>
    
    <xsl:variable name="vE" select="xs:decimal($pE)"/>
    <xsl:variable name="vN" select="xs:decimal($pN)"/>
    

    <xsl:sequence select=
     "if($pE eq 1)
       then 2
       else
         for $half in f:pow2mod($pE idiv 2, $pN)
           return
              ($half * $half  mod $pN)* (1 + ($pE mod 2)) mod $pN
          
     "/>
  </xsl:function>

<!--
    f:powMNmodK(M, N, k) = M^N mod k
-->  
  <xsl:function name="f:powMNmodK" as="xs:decimal">
    <xsl:param name="pM" as="xs:decimal"/>
    <xsl:param name="pN" as="xs:decimal"/>
    <xsl:param name="pK" as="xs:decimal"/>
    
    <xsl:variable name="vM" as="xs:decimal" 
     select="xs:decimal($pM)"/>
    <xsl:variable name="vN" as="xs:decimal"
     select="xs:decimal($pN)"/>
    <xsl:variable name="vK" as="xs:decimal"
     select="xs:decimal($pK)"/>
    

    <xsl:sequence select=
     "if($vN eq 1)
       then $vM mod $vK
       else
         for $half in f:powMNmodK($vM, $vN idiv 2, $vK)
           return
              $half * $half * 
                (1 + ($vM -1)*xs:decimal($vN mod 2 = 1)) mod $vK
          
     "/>

  </xsl:function>

  <xsl:function name="f:allPrimes" as="xs:integer*" >
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:sequence select="(2,3,5,7)[. le $pN], ((11 to $pN)[f:isPrime(.)])"/> 
  </xsl:function>

  <xsl:function name="f:nextPrime" as="xs:integer" >
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:sequence select=
     "($pN +1 to 2*$pN)[f:isPrime(.)][1]"/> 
  </xsl:function>
  
  <xsl:function name="f:nextPrime" as="element()" >
    <f:nextPrime/> 
  </xsl:function>
  
  <xsl:template match="f:nextPrime" mode="f:FXSL" as="xs:integer">
    <xsl:param name="arg1" as="xs:integer"/>
    
    <xsl:sequence select="f:nextPrime($arg1)"/>
  </xsl:template>
  
  
  
  <xsl:function name="f:divisor" as="xs:boolean"  saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pK" as="xs:integer"/>
    <xsl:param name="pN" as="xs:integer"/>
    
    <xsl:sequence select="$pN mod $pK = 0"/>
  </xsl:function>
</xsl:stylesheet>