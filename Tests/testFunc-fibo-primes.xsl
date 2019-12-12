<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs saxon f" 
 >
  <xsl:import href="../f/func-Fibonacci.xsl"/>
  <xsl:import href="../f/func-Primes.xsl"/>

 <xsl:output method="text"/>
 
<!--
    Solves the following problem:                   												
                                                                						
    Find the first 10-digit prime in consecutive digits of F-3000						
                                                                 						
    Where F-N is the Nth Fibonacci number.                             			
                                                                          	
    Here are the elements of the sequence of Fibonacci numbers from 0 to 11:
                                                                            
    Element:    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144                   
    Index:      0, 1, 2, 3, 4, 5,  6,  7,  8,  9, 10,  11                   
                                                                            
   Invoke on any xml file or with an initial template named "initial".      
                                                                            
   Expected result: 0072280217                                              

-->
 
  <xsl:variable name="vFib" select="xs:string(f:fibo(3000))"/>
 
  <xsl:template name="initial" match="/">
   The first prime from a sequence of 
   ten consecutive digits in Fibonacci's number F3000:
<xsl:text/>
   <xsl:value-of select="$vFib"/>
   Is: <xsl:text/>
   <xsl:value-of select=
   "(
     for $n in 1 to string-length($vFib)-9
                  return(substring($vFib, $n, 10))
     )
     [f:isPrime(xs:integer(.))][1]
   "/>
  </xsl:template>

</xsl:stylesheet>