<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:output omit-xml-declaration="yes" indent="yes"/> 
 <xsl:template match="/">
 
   <xsl:variable name="vstrParam" as="xs:string">
      (:  123 "Xa xa xa Mike's bike"  :) 456.789 .23
      .5e10 .5E-10 8e2 9.e3 11.25E4
      
        ' Elli is "the Princess" '
        " Elli and 'the Princess' "
        " Elli or ""the Princess"" "
        ' Elli gt ''the Princess'' '
        ' Elli instance of ''the Princess'' '
        'O''Connor'
        'Don''t say &quot;yes&quot;'
        
        or gt eq is treat as union instance of every $ lt
        
        a:b123.c.d  син:червен
        
        for $i in x
           return 3
           
           ../a[. > b] | c[. >> d]
           
           //namespace::* 
           
           child::*  descendant  ::  *
           
           ancestor-or-self  :: xyz
           
           /a[b = c]
           
           empty  ( )
           
           empty()
           
           item ( )
           
           element()  attribute
             ( )
             
             Elli:*
             
             *:Mitko
             
             and and or
        
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
    select="f:lexer-XPath($vStr, $pinpIndex)"/>
    
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
 
 <xsl:variable name="vRegExXPath" as="xs:string">
   ([\s]*)          <!-- Skip leading whitespace -->
                    <!-- Followed by: -->
   (  
      (\(:)         <!-- Comment start --> 
     
     |
      (:\))
     |
       (             <!-- DoubleLiteral -->
          (
           (\.[0-9]+) <!-- FractionalTermDouble -->
          |
           ([0-9]+ (\.[0-9]*)?) <!-- MixedTermDouble -->
           )
                                <!-- Followed by ExponentiationPart -->
            ([eE]) ([-+])? [0-9]+
        )
     |
      (             <!-- DecimalLiteral -->
         (\.[0-9]+) <!-- FractionalDecimal --> 
        |
         ([0-9]+\.[0-9]*) <!-- MixedDecimal -->
       )
     |
      ([0-9]+)      <!-- IntegerLiteral -->
      
     |
      (             <!-- StringLiteral -->
         ("([^"])*")+
        |
         ('([^'])*')+
       )
       
     |
      (           <!-- Named operators -->
                       <!-- boolean ops -->
        (
           (or) 
         | 
           (and)
         ) 
       |               <!-- value comparisons -->
        ( 
          (eq) 
        | (ne)
        | (lt) 
        | (le)
        | (gt) 
        | (ge)
         ) 
       |
        (is)           <!-- identity comparison -->
       |
        (to)           <!-- range delim -->
       |
        ( 
          (div)        <!-- div-like ops -->
         |(idiv)
         |(mod)
        )         
       |
        ( 
          (union)        <!-- set/seq operators -->
         |(intersect)
         |(except)
        )         
       |
        (
          (instance [\s]+ of)        <!-- type operators -->
         |(cast [\s]+ as)
         |(castable [\s]+ as)
         |(treat [\s]+ as)
        )         
       )
       [\s]+             <!-- These named Ops must
                              be followed   by WS -->

       |
        ( 
          (for [\s]* \$)  <!-- Higher order ops -->
         |(some [\s]* \$)
         |(every [\s]* \$)
         |(if [\s]* \()
        )  
        
       |
        (
          (then [\s]+)
         |
          (else [\s]+)
         |
          (in [\s]+)
         |
          (return [\s]+)
         |
          (satisfies [\s]+)
         )
         
       |
        (
          (child [\s]* :: ) <!-- CHILD_AXIS -->
         |
          (descendant [\s]* :: ) <!-- DESCENDANT_AXIS -->
         |
          (attribute [\s]* :: ) <!-- ATTRIBUTE_AXIS -->
         |
          (self [\s]* :: ) <!-- SELF_AXIS -->
         |
          (descendant-or-self [\s]* :: ) <!-- DESCENDANT_OR_SELF_AXIS -->
         |
          (following-sibling [\s]* :: ) <!-- FOLLOWING_SIBLING_AXIS -->
         |
          (following [\s]* :: ) <!-- FOLLOWING_AXIS -->
         |
          (namespace [\s]* :: ) <!-- NAMESPACE_AXIS -->
         |
          (parent [\s]* :: ) <!-- PARENT_AXIS -->
         |
          (ancestor [\s]* :: ) <!-- ANCESTOR_AXIS -->
         |
          (preceding-sibling [\s]* :: ) <!-- PRECEDING_SIBLING_AXIS -->
         |
          (preceding [\s]* :: ) <!-- PRECEDING_AXIS -->
         |
          (ancestor-or-self [\s]* :: ) <!-- ANCESTOR_OR_SELF_AXIS -->
        )        
       
       |
        (                              <!-- Types -->
          (empty [\s]* \( [\s]* \) )   <!-- EMPTY_TYPE -->
         |
          (item [\s]* \( [\s]* \) )    <!-- ITEM_TYPE -->
        )
       |
        (                              <!-- Tests -->
          (element [\s]* \( )          <!-- ELEMENT_TEST -->
         |
          (attribute [\s]* \(  )       <!-- ATTRIBUTE_TEST -->
         |
          (schema-element [\s]* \(  )  <!-- SCHEMA_ELEMENT_TEST -->
         |
          (schema-attribute [\s]* \(  ) <!-- SCHEMA_ATTRIBUTE_TEST -->
         |
          (processing-instruction [\s]* \(  ) <!-- PROCESSING_INSTRUCTION_TEST -->
         |
          (document-node [\s]* \(  )   <!-- DOCUMENT_NODE_TEST -->
         |
          (comment [\s]* \( [\s]* \)  )<!-- COMMENT_TEST -->
         |
          (text [\s]* \( [\s]* \) )    <!-- COMMENT_TEST -->
         |
          (node [\s]* \( [\s]* \) )    <!-- TEXT_TEST -->
        )
       |
        (                              <!-- Wildcards -->
          ([\i-[:]][\c-[:]]*:\*)       <!-- WILD_NAME -->
         |
          (\*:[\i-[:]][\c-[:]]*)       <!-- WILD_PREFIX -->
         )
       |  
        (                  <!-- QName2 -->
          ([\i-[:]][\c-[:]]*:)?[\i-[:]][\c-[:]]*
         )
       |
        (          <!-- Other literal tokens -->
	          (,)
	          
		        |      <!-- Ordering comparisons between nodes -->
		         (
		           (&lt;&lt;) | (>>)
		          )
		        |      <!-- Arithmetic Operators -->
		         (
		           (\+) | (\-) | (\*)
		          )
		        |
		          (\|) <!-- Union : literal op -->
		        |
		          (//)  <!-- // abbreviation -->
		        |
		          (/)  <!-- XPath Slash operator -->
		        |
		          (   <!-- Brackets -->
		             (\() | (\))
		            |
		             (\[)  | (\])
		           )
		         |     <!-- Axis delimiter -->
		           (::)
		         |
		           (@) <!-- Attribute name starter abbreviation-->
		           
		         |     <!-- Parent node abbreviation -->
		           (\.\.)
		         
		         |     <!-- Current node abbreviation -->
		           (\.)
		           
		         |
		           (\?)
	          
	          
	         | 
	          (        <!-- General Comparison operators -->
		           (=)
		          |
		           (!=)
		          |
		           (&lt;)
		          |
		           (&lt;=)
		          |
		           (>)
		          |
		           (>=)
		        )
		        
		       | (\$)

         )       

    )              <!-- These are all our token types -->
      (.*)$        <!-- Only get the first token,
                        Skip the rest for the future -->
 </xsl:variable>
 
 <xsl:function name="f:lexer-XPath" as="item()*">
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
		       regex="{$vRegExXPath}">

		      <xsl:matching-substring>
            <xsl:variable name="vToken" as="xs:string?"
             select="regex-group(2)"/>
            
            <xsl:variable name="vToken2" as="xs:string" 
             select="if(regex-group(47))
                       then normalize-space(
                                       substring($vToken,
                                                 1,
                                                 string-length($vToken)-1)
                                            )
                       else ''
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
             string-length($vToken) - (if($vToken2 eq '') then 0 else 1)
               ,
               
             if(regex-group(3))
               then 'COMMENT_START'
               else if(regex-group(4))
                 then 'COMMENT_END'
                  else if(regex-group(5))
                   then 'DOUBLE_LITERAL'
                     else if(regex-group(12))
                     then 'DECIMAL_LITERAL'
                       else if(regex-group(15))
                       then 'INTEGER_LITERAL'
                       else if(regex-group(16))
                        then 'STRING_LITERAL'
                        else if(regex-group(21))
                         then 
                              (if(not(regex-group(42)))
                                 then upper-case(normalize-space($vToken))
			                           else 
			                             translate(upper-case(normalize-space($vToken)),
			                                       ' ',
			                                       '_'
			                                      )
			                         )
			                   else if(regex-group(47))
			                      then ('FOR', 'SOME','EVERY','IF')
			                              [starts-with
			                                   (.,
                                          upper-case(substring(regex-group(47),1,1)))
                                     ]
					                  else if(regex-group(52))
					                     then ('THEN', 'ELSE','IN','RETURN', 'SATISFIES')
					                             [starts-with
					                                  (.,
		                                         upper-case(substring(regex-group(52),1,1)))
		                                    ]
					                     else if(regex-group(58))
					                          then 
					                          concat(translate
					                                  (upper-case
					                                     (substring-before
					                                        (translate
					                                           (normalize-space($vToken),
					                                            ' ',''
		                                                  ), 
					                                         '::'
					                                         )
					                                      ),
                                             '-', '_'
                                             ),
                                            '_AXIS'
                                           )
					                     
					                     else if(regex-group(72))
					                        then 
					                          concat(
					                                  upper-case
					                                     (translate
					                                       ($vToken, 
					                                       ' &#xA;&#xD;&#9;()','')
			                                          ),
					                                  '_TYPE'
					                                 )
					                     else if(regex-group(75))
					                        then 
					                          concat(
					                                  upper-case
					                                     (translate
					                                       ($vToken, 
					                                       ' &#xA;&#xD;&#9;()','')
			                                          ),
					                                  '_TEST'
					                                 )
					                     else if(regex-group(86))
					                         then 'WILD_NAME'
					                     else if(regex-group(87))
					                         then 'WILD_PREFIX'
					                     
					                     else if(regex-group(88))
					                        then 'QNAME2'
					                        else if(regex-group(90))
							                           then (if(regex-group(99))
									                                then 'UNION'
									                                else $vToken
									                              )

		                                      else 'RegEx-Error'
                  ,
             if(regex-group(16))
               then f:processStringToken($vToken)
               else if(regex-group(21) or regex-group(52))
                    then normalize-space($vToken)
                    else if(regex-group(47))
                         then $vToken2
                         
                         else if(regex-group(58) or regex-group(72)
                                or
                                 regex-group(75)
                                 )
                              then translate($vToken, ' &#xA;&#xD;&#9;','')
                         else $vToken	            
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

 <xsl:variable name="vQ" as="xs:string">"</xsl:variable>
 <xsl:variable name="vApos" as="xs:string">'</xsl:variable>

 <!-- Deletes the starting and ending quotes
     Replaces any internal pair of these quotes
     to a single one
   -->
 <xsl:function name="f:processStringToken" 
      as="xs:string?">
   <xsl:param name="pStr" as="xs:string?"/>
   
   <xsl:variable name="vStartQ" as="xs:string"
        select="substring($pStr,1,1)"/>
   
   <xsl:variable name="vTail" as="xs:string"
     select="substring($pStr,2)"/>
   
   <xsl:variable name="vTail2" select=
    "substring($vTail,1,string-length($vTail)-1)"/>
    
   <xsl:sequence select=
    "if(contains($vTail2,$vStartQ))
       then replace($vTail2,
                    concat($vStartQ,$vStartQ),
                    $vStartQ
                    )
       else $vTail2
    "
    />
 </xsl:function>

 
</xsl:stylesheet>