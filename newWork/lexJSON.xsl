<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:output omit-xml-declaration="yes" indent="yes"/> 
 <xsl:template match="/">
 
   <xsl:variable name="vstrParam" as="xs:string">
{
    "glossary": {
        "title": "example glossary",
		"GlossDiv": {
            "title": "S",
			"GlossList": {
                "GlossEntry": {
                    "ID": "SGML",
					"SortAs": "SGML",
					"GlossTerm": "Standard Generalized Markup Language",
					"Acronym": "SGML",
					"Abbrev": "ISO 8879:1986",
					"GlossDef": {
                        "para": "A meta-markup language, used to create markup languages such as DocBook.",
						"GlossSeeAlso": ["GML", "XML"]
                    },
          "GlossPriority" : 3,
					"GlossSee": "markup"
                }
            }
        }
    }
}

   </xsl:variable>
   <xsl:sequence select="f:do-lex($vstrParam, 1)"
   />
 </xsl:template>
 
 <xsl:function name="f:do-lex">
   <xsl:param name="pStr" as="xs:string"/>
   <xsl:param name="pinpIndex" as="xs:integer"/>
   
   <xsl:variable name="vStr" as="xs:string"
        select=
      "concat($pStr, 
              if(not(ends-with($pStr, ' ')))
                then ' '
                else ()
              )
      "/>
    
    
    
   <xsl:variable name="vLexResults" as="item()+"
    select="f:lexer-Jason($vStr, $pinpIndex)"/>
    
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
        "f:do-lex($vStr, $vnewIndex)"/>
    </xsl:if>
   
 </xsl:function>
 
 <xsl:variable name="vRegExJSON" as="xs:string">
   ([\s]*)          <!-- Skip leading whitespace -->
                    <!-- Followed by: -->
   (  
     ("[^"\\]*((\\.[^"\\]*)*")) <!-- A string -->
    |                           <!-- Or a Number -->
      ((([-]?[0-9]+)?\.)?[-]?[0-9]+([eE][-+]?[0-9]+)? )
    |
      ( (true)|(false)|(null)  <!-- Or true 
                                   or false or null -->
                    
       | 
         [{},:\[\]]            <!-- Or one of these:
                                   '{', '}', ':',
                                   '[', ']' -->
                    
         )\W       <!-- Followed by a non-word char-->
      )            <!-- These are all our token types -->
      (.*)$        <!-- Only get the first token,
                        Skip the rest for the future -->
 </xsl:variable>
 
 <xsl:function name="f:lexer-Jason" as="item()*">
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

		     <xsl:analyze-string select="$vstrInput"  flags="mx"
		       regex="{$vRegExJSON}">

		      <xsl:matching-substring>
            <xsl:variable name="vToken" 
             select="regex-group(2)"/>

            <xsl:variable name="vToken2" select=
            "if(regex-group(10))
              then substring($vToken, 1, string-length($vToken) - 1)
              else $vToken
            "/>
<!--
            <xsl:message>
              $vToken: |<xsl:sequence select="$vToken"/>|
              regex-groups: 
                <xsl:for-each select="1 to 20">
                  regex-group(<xsl:value-of select="."/>): |<xsl:value-of select="regex-group(.)"/>|
                </xsl:for-each>
            </xsl:message>
-->            

            <xsl:sequence select=
            "$pinpIndex
            +
             string-length(substring-before($vstrInput,$vToken))
            +
             string-length($vToken)
             
             - 1 * (if(regex-group(10)) then 1 else 0)
               ,
               
             if(regex-group(3))
               then 'STRING'
               else if(regex-group(6))
                 then 'NUMBER'
                 else if(regex-group(10)) 
                   then upper-case($vToken2)
                   else 'RegEx-Error',
             $vToken2		            
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