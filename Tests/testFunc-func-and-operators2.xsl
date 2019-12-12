<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
  <xsl:import href="../f/func-map.xsl"/>
  
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  <!-- To be run against: ../data/testFunc-func-and-operators2.xml -->
 
 <xsl:template match="/">
  <xsl:for-each select=
   "for $indEntry in 1 to count(/*/entry),
        $ind-r_entry in 1 to count(/*/entry[$indEntry]/r_entries/r) 
      return 
         f:map(f:insert-before(data(/*/entry[$indEntry]/r_entries/r[$ind-r_entry]/@val),1), 
               data(/*/entry[$indEntry]/k_entries/*/@val)
               )"
  >
  
   <xsl:value-of select="if(position() mod 2 = 1) then
                            (position() + 1) idiv 2,
                            ', ', ., ', '
                         else
                            (. , '&#xA;')
                                "/>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>