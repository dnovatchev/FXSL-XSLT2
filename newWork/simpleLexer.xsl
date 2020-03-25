<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="../f/func-apply.xsl"/>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
 <xsl:template match="/">
   <xsl:sequence select="f:do-lex('  0   +     1   *  ', 1)"
   />
 </xsl:template>
 
 <xsl:function name="f:do-lex">
   <xsl:param name="pStr" as="xs:string"/>
   <xsl:param name="pinpIndex" as="xs:integer"/>
   
   <xsl:variable name="vLexResults" as="item()+"
    select="f:apply(f:simple-lexer(),$pStr, $pinpIndex)"/>
    
    <xsl:variable name="vToken" as="xs:string"
     select="$vLexResults[2]"/>
     
    <xsl:variable name="vValue" as="item()?"
     select="$vLexResults[3]"/>
     
    <xsl:variable name="vnewIndex" as="xs:integer"
     select="$vLexResults[1]"/>
  
<!--    <xsl:sequence select="$vToken"/>  -->

    <term name="{$vToken}">
      <xsl:choose>
		    <xsl:when test="$vToken eq 'error'">
		      <xsl:attribute name="at" select="$pinpIndex"/>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:sequence select="$vValue"/>
		    </xsl:otherwise>
      </xsl:choose>
    
    </term>
    
    <xsl:if test="not($vToken = ('$end', 'error'))">
      <xsl:sequence select=
        "f:do-lex($pStr, $vnewIndex)"/>
    </xsl:if>
   
 </xsl:function>
 
 <xsl:function name="f:simple-lexer" as="element()">
  <f:simple-lexer/>
 </xsl:function>
 
 <xsl:template match="f:simple-lexer" as="item()*"
    mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:simple-lexer($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:simple-lexer" as="item()*">
   <xsl:param name="pstrInput" as="xs:string"/>
   <xsl:param name="pinpIndex" as="xs:integer"/>
   
   <xsl:variable name="vstrInput" select=
     "substring($pstrInput, $pinpIndex)"/>
   
     <xsl:choose>
       <xsl:when test="not($vstrInput)">
         <xsl:sequence select=
          "$pinpIndex,'$end'"/>
       </xsl:when>
       <xsl:otherwise>
		     <xsl:analyze-string select="$vstrInput"
		      regex="([\s]*)([01+*])(.*)$" flags="mx">
		       
		      <xsl:matching-substring>
            <xsl:variable name="vToken" 
             select="regex-group(2)"/>
            
            <xsl:sequence select=
            "$pinpIndex
            +
             string-length(substring-before($vstrInput,$vToken))
            +
             string-length($vToken)
               ,
               
             $vToken,
             $vToken		            
            "
            />
		      </xsl:matching-substring>
		      
		      
		      <xsl:non-matching-substring>
		        <xsl:choose>
	            <xsl:when test="normalize-space()">
		            <xsl:sequence select=
		             "$pinpIndex, 'error'
		             "/>
	             </xsl:when>
	             <xsl:otherwise>
		            <xsl:sequence select=
		             "$pinpIndex, '$end'
		             "/>
	             </xsl:otherwise>
		        </xsl:choose>
		      </xsl:non-matching-substring>
		     </xsl:analyze-string>
	     </xsl:otherwise>
     </xsl:choose>    
 </xsl:function>
</xsl:stylesheet>