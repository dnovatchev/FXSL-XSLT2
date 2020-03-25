<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:f="http://fxsl.sf.net/"
   xmlns:my="my"
   exclude-result-prefixes="#all"
   version="2.0">

   <xsl:import href="XPathParse1.xsl"/>

   <xsl:variable name="expressions" as="element()+">
      <e>for $v in () return $v</e>
      <e>for $one in $some/path return
           $one/other/path()</e>
   </xsl:variable>

   <xsl:template match="/" name="main">
      <xsl:for-each select="$expressions">
         <expr xp="{ . }">
            <xsl:sequence select="my:serialize(., 1, f:XPathParse(.)/*)"/>
         </expr>
      </xsl:for-each>
   </xsl:template>

   <xsl:function name="my:consume-whitespaces" as="xs:integer">
      <xsl:param name="input" as="xs:string"/>
      <xsl:param name="idx"   as="xs:integer"/>
      <xsl:choose>
         <xsl:when test="substring($input, $idx, 1) = (' ', '&#10;', '&#9;')">
            <xsl:sequence select="1 + my:consume-whitespaces($input, $idx + 1)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:sequence select="0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>

   <xsl:function name="my:serialize">
      <xsl:param name="input"   as="xs:string"/>
      <xsl:param name="idx"     as="xs:integer"/>
      <xsl:param name="grammar" as="element()"/>
      <xsl:if test="$idx le string-length($input)">
         <xsl:variable name="white-len" select="my:consume-whitespaces($input, $idx)"/>
         <xsl:if test="$white-len gt 0">
            <w>
               <xsl:value-of select="substring($input, $idx, $white-len)"/>
            </w>
         </xsl:if>
         <xsl:variable name="new-idx" select="$idx + $white-len"/>
         <xsl:variable name="new-grammar" select="
             $grammar/(descendant::*|following::*)[empty(*)][count(text()) eq 1][1]"/>
         <xsl:variable name="token" select="string($new-grammar)"/>
         <xsl:if test="substring($input, $new-idx, string-length($token)) ne $token">
            <xsl:sequence select="error((), 'WTF?', ($idx, $new-idx, $token))"/>
         </xsl:if>
         <t>
            <xsl:value-of select="$token"/>
         </t>
         <xsl:sequence select="my:serialize($input, $new-idx + string-length($token), $new-grammar)"/>
      </xsl:if>
   </xsl:function>

</xsl:stylesheet>