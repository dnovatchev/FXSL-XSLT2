<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
 <xsl:template match="/">
  <concord>
    <xsl:sequence select="f:wordConcord(/,'loved')"/>
  </concord>
  
 </xsl:template>
 
 <xsl:function name="f:wordConcord" as="element()*">
   <xsl:param name="pDoc" as="document-node()"/>
   <xsl:param name="pWord" as="xs:string"/>
   
   <xsl:for-each select=
    "$pDoc/tstmt/bookcoll/book/chapter/(.|div)
                               /v[contains(.,$pWord)]">
      <xsl:variable name="vverseWords" 
       select="tokenize(lower-case(string(.)), '[\s.?!,;—:\-]+')[.]"/>
       
      <xsl:if test="$pWord = $vverseWords">
       <xsl:variable name="vVerse" select="."/>
       <xsl:for-each select="$vverseWords[. = $pWord]">
		     <occurs w="{$pWord}" 
		       book="{substring($vVerse/ancestor::book[1]/bktshort,1,3)}"
		       chapter="{count($vVerse/ancestor::chapter[1]
		                             /preceding-sibling::chapter)+1}"
		       verse="{count($vVerse/preceding-sibling::v)+1}"
		     >
		      <xsl:sequence select=
		      "f:displayContext(string($vVerse), $pWord, position(), 15)"
		      />
		     </occurs>
	     </xsl:for-each>
	   </xsl:if>
   </xsl:for-each>
 </xsl:function>
 
 <xsl:function name="f:displayContext" as="xs:string">
  <xsl:param name="pText" as="xs:string"/>
  <xsl:param name="pWord" as="xs:string"/>
  <xsl:param name="pwordNum" as="xs:integer"/>
  <xsl:param name="pRadius" />
   
   <xsl:variable name="vwOffset" select=
   "f:nthWord($pText, $pWord, $pwordNum, 0)"
   />
   
   <xsl:variable name="vWLen" select="string-length($pWord)"/>
   
   <xsl:variable name="vText2" select=
   "concat(substring($pText,1,$vwOffset ),
           substring($pWord,1,1),
           '.',
           substring($pText,$vwOffset+$vWLen+1)
           )"
   />
   <xsl:variable name="vStart" select=
   "if($vwOffset > $pRadius)
     then $vwOffset - $pRadius
     else 1"
   />
   <xsl:sequence select=
   "substring($vText2, $vStart, 2*$pRadius+$vWLen)"
   />
 </xsl:function>
 
 <xsl:function name="f:nthWord" as="xs:integer">
  <xsl:param name="pText" as="xs:string"/>
  <xsl:param name="pWord" as="xs:string"/>
  <xsl:param name="pwordNum" as="xs:integer"/>
  <xsl:param name="pOffset" as="xs:integer"/>
  
  <xsl:variable name="vZ" select="'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'"/>
  <xsl:variable name="vWLen" select="string-length($pWord)"/>
  <xsl:variable name="vTLen" select="string-length($pText)"/>
  
  <xsl:variable name="vZWord" select=
                "substring($vZ,1,$vWLen)"/>
  
  <xsl:sequence select=
   "if($pwordNum lt 1)
      then $pOffset - $vWLen +1
      else
        for $txt in replace($pText, concat('[^\w]',$pWord,
                            '[^\w]'), 
                            concat(' ',$vZWord, ' ')
                            ),
        $off in string-length(substring-before($txt,$vZWord))
          return 
            f:nthWord(substring($pText, $off + $vWLen),
                      $pWord,
                      $pwordNum - 1,
                      $pOffset
                      +$vTLen -string-length(substring-after($txt,$vZWord)) -1
                      )
    "
   />
 </xsl:function>
</xsl:stylesheet>