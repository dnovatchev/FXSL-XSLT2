<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-XpathConstructors.xsl"/>
  <xsl:import href="../f/func-map.xsl"/>
  
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  <!-- To be run against: ../data/testFunc-XPathConstructors.xml -->
 
 <xsl:template match="/">
  Sum As decimals: <xsl:value-of select=
   "sum(f:map(f:decimal(), 
        /*/claim/claim_line/reimbursement_amount)
        )"/>
        
  Sum as floats (default):  <xsl:value-of select=
   "sum(/*/claim/claim_line/reimbursement_amount)"/>
 </xsl:template>
</xsl:stylesheet>