<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="func-lrParse.xsl"/>
 
 <!-- To be applied on: parseTables-SimpleExpr.xml -->
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 <xsl:template match="/">
   <xsl:sequence select=
    "f:lrParse(/*, 
                    '1 +   1*0   + 1 ',
                    1,
                    (),
                    (0),
                    (),
                    f:simple-lexer(),
                    f:OnRuleReduced() 
               )"
    />
 </xsl:template>

 <xsl:function name="f:OnRuleReduced" as="element()">
   <f:OnRuleReduced/>
 </xsl:function>
 
 <xsl:template match="f:OnRuleReduced" mode="f:FXSL"
  as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()*"/>
  
   <xsl:sequence select="f:OnRuleReduced($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:OnRuleReduced" as="element()">
   <xsl:param name="pRule" as="element()"/>
   <xsl:param name="pValStack" as="element()*"/>
   
   <xsl:variable name="vCompValues" as="element()*"
    select="$pValStack[position() le xs:integer($pRule/@length)]"/>
   
   <sym name="{$pRule/@left}"
    computedValue="{f:computedValue($vCompValues,
                                    $pRule/@length
                                    )
                    }"
    >
     <components>
       <xsl:sequence select="$vCompValues"/>
     </components>
   </sym>
 </xsl:function>

 <xsl:function name="f:computedValue" as="item()*">
   <xsl:param name="pComponents" as="element()*"/>
   <xsl:param name="pLength" as="xs:integer"/>
<!--   
   <xsl:message>
    f:computedValue:
      Length: <xsl:sequence select="$pLength"/>
      Components: <xsl:sequence select="$pComponents"/>
   </xsl:message>
-->   
   <xsl:if test="$pLength gt 0">
     <xsl:sequence select=
      "if($pLength ne 3)
         then f:argValue($pComponents[1])
         else
           for $op in $pComponents[2],
               $arg1 in f:argValue($pComponents[1]),
               $arg2 in f:argValue($pComponents[3])
                 return
                  if($op eq '+')
                     then $arg1 + $arg2
                     else if($op eq '*')
                       then $arg1 * $arg2
                       else 'ERROR !!!'
         
         "
      />
   </xsl:if>
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