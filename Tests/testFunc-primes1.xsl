<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs saxon f" 
 >
  <xsl:import href="../f/func-Primes.xsl"/>

 <!-- To be applied on any xml file, or with initial template named "initial"
      
      Expected result: The primes from 2 to 99991.
-->

 <xsl:output method="text"/>

  <xsl:template name="initial" match="/*">
   <xsl:value-of select="f:allPrimes(100000)" separator="&#xA;"/>
  </xsl:template>

</xsl:stylesheet>