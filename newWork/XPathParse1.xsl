<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="../f/func-lrParse.xsl"/>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:variable name="vstrParam" as="element()">
  <all>
	  <expr>
	    f:lrParse($vJasonPPTables,
	              $pstrJason,
	              1,
	              (),
	              (0),
	                    (),
	                    f:lexer-JSON(),
	                    f:OnJSONRuleReduced() 
		               )
		                /computedValue/node()
	  </expr>
	  <expr>
	    $pRule/@left
	  </expr>
	  
	  <expr>
	    $pValStack[position() le xs:integer($pRule/@length)]
	  </expr>
	  
	  <expr>
	    for $len in count($vCompValues),
	        $i in 0 to $len - 1
	           return $vCompValues[$len - $i]
	  </expr>
	  
	  <expr>
	    if($vruleLength eq 1)
	       then $pComponents[1]/computedValue/node()
	        else
	          if($vruleLength eq 3)
	            then
	              ($pComponents[3]/computedValue/node(),
	               $pComponents[1]/computedValue/node()
	               )
	            else 'MEMBERS rule Error!!!'
	  </expr>
	    
	  <expr>
	    not($pRule/right = ('OBJECT','ARRAY'))
	  </expr>
	  
	  <expr>
	    $pinpIndex
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
	             if(regex-group(3))
	                then f:unQuote($vToken2)
	                else $vToken2		  
	  </expr>
	  <expr>
	    and and or
	  </expr>
	  <expr>
	    $div div $idiv
	  </expr>
  </all>
  
 </xsl:variable>

 <xsl:variable name="vXPathPPTables" select=
  "document('XPATH-ParseTables.xml')/*"/>
 
 <xsl:function name="f:XPathParse" as="document-node()?">
   <xsl:param name="pstrXPath" as="xs:string"/>
   
   <xsl:variable name="vparseResult">
	   <xsl:sequence select=
	    "f:lrParse($vXPathPPTables,
	                    $pstrXPath,
	                    f:lexer-XPath(),
	                    f:OnXpathRuleReduced() 
	               )
	                /computedValue/node()
     "
	    />
    </xsl:variable>
    
    <xsl:sequence select="$vparseResult"/>
 </xsl:function>
 
 <xsl:template match="/">
    <xsl:sequence select="f:XPathParse($vstrParam/expr[1])"/>
 </xsl:template>

 <xsl:function name="f:OnXpathRuleReduced" as="element()">
   <f:OnXpathRuleReduced/>
 </xsl:function>
 
 <xsl:template match="f:OnXpathRuleReduced" mode="f:FXSL"
  as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()*"/>
  
   <xsl:sequence select="f:OnXpathRuleReduced($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:OnXpathRuleReduced" as="element()">
   <xsl:param name="pRule" as="element()"/>
   <xsl:param name="pValStack" as="element()*"/>
<!--   
   <xsl:message>
     f:OnXpathRuleReduced:
     $pRule: '<xsl:sequence select="$pRule"/>'
     $pValStack: '<xsl:sequence select="$pValStack"/>'
   </xsl:message>
-->   
   <xsl:variable name="vCompValues" as="element()*"
    select="$pValStack[position() le xs:integer($pRule/@length)]"/>
   
   <sym name="{$pRule/@left}">

    <computedValue>
      <xsl:sequence select=
      "f:computedValue($vCompValues,$pRule)"/>
    
    </computedValue>
<!---->
     <components>
       <xsl:sequence select=
        "for $len in count($vCompValues),
             $i in 0 to $len - 1
                return $vCompValues[$len - $i]
        "/>
     </components>
   </sym>
 </xsl:function>

 <xsl:function name="f:computedValue" as="item()*">
   <xsl:param name="pComponents" as="element()*"/>
   <xsl:param name="pRule" as="element()"/>
<!--   
   <xsl:message>
    f:computedValue:
      Length: <xsl:sequence select="$pRule/@length"/>
      Components: <xsl:sequence select="$pComponents"/>
   </xsl:message>
-->   
   <xsl:variable name="vruleLength" as="xs:integer"
        select="$pRule/@length"/>
   
   <xsl:variable name="vLen1" as="xs:integer" 
        select="$vruleLength+1"/>
   
   <xsl:variable name="vlhsName" select="$pRule/@left"/>
   
   <rule left="{$vlhsName}">
     <xsl:for-each select="1 to $vruleLength">
       <right>
         <xsl:sequence select=
           "for $comp in $pComponents[$vLen1 - current()]
                return
                   if(exists($comp/computedValue) )
                       then $comp/computedValue/node()
                       else $comp/node()
                   
           "/>
       </right>
     </xsl:for-each>
   </rule>
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

 <xsl:function name="f:lexer-XPath" as="element()">
  <f:lexer-XPath/> 
<!-- 
   <xsl:message>f:f:lexer-XPath()
   
   </xsl:message>
-->
  </xsl:function>
 
 <xsl:template match="f:lexer-XPath" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:integer"/>
<!--
   <xsl:message>
     template match="f:lexer-XPath":
     $arg1: '<xsl:sequence select="$arg1"/>'
     
     $arg2: '<xsl:sequence select="$arg2"/>'
   </xsl:message>
-->   
   
   <xsl:sequence select="f:lexer-XPath($arg1, $arg2)"/>
 </xsl:template>


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


 
 <xsl:function name="f:argValue" as="xs:integer">
   <xsl:param name="parg1" as="item()"/>
   
   <xsl:sequence select=
    "if($parg1/self::term)
       then xs:integer($parg1)
       else xs:integer($parg1/@computedValue)
    "
    />
 </xsl:function>
</xsl:stylesheet>