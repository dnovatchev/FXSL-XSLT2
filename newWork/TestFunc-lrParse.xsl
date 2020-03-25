<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="func-lrParse.xsl"/>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:variable name="vsimpleExprPPTables" select=
  "document('../data/simpleExprParseTables.xml')/*"/>
 
 <xsl:template match="/">
   <xsl:sequence select=
    "f:lrParse($vsimpleExprPPTables,
                    '3 + 4*5 - (7%3)',
                    1,
                    (),
                    (0),
                    (),
                    f:lexer-simpleExpr(),
                    f:OnSimpleExprRuleReduced() 
               )
                 (: /computedValue/node() :)
     "
    />
 </xsl:template>

 <xsl:function name="f:OnSimpleExprRuleReduced" as="element()">
   <f:OnSimpleExprRuleReduced/>
 </xsl:function>
 
 <xsl:template match="f:OnSimpleExprRuleReduced" mode="f:FXSL"
  as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()*"/>
  
   <xsl:sequence select="f:OnSimpleExprRuleReduced($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:OnSimpleExprRuleReduced" as="element()">
   <xsl:param name="pRule" as="element()"/>
   <xsl:param name="pValStack" as="element()*"/>

   <xsl:variable name="vCompValues" as="element()*"
    select="$pValStack[position() le xs:integer($pRule/@length)]"/>
   
   <sym name="{$pRule/@left}">

    <computedValue>
      <xsl:sequence select=
      "f:computedValue($vCompValues,$pRule)"/>
    
    </computedValue>
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


   <xsl:variable name="vruleLength" as="xs:integer"
        select="$pRule/@length"/>
   
   <xsl:variable name="vLen1" as="xs:integer" 
        select="$vruleLength+1"/>
   
   <xsl:variable name="vlhsName" select="$pRule/@left"/>
   
   <xsl:if test="$vruleLength gt 0">
     <xsl:choose>
       <xsl:when test="$vruleLength eq 1">
         <!-- expr :: NUMBER -->
         <xsl:sequence select="number($pComponents[1])"/>
       </xsl:when>
       <xsl:when test="$vruleLength eq 2">
         <xsl:sequence select=
          "if($pComponents[2] eq '-')
             then -1*number($pComponents[1]/computedValue)
             else number($pComponents[2]/computedValue)
          "
          />
       </xsl:when>
       <xsl:when test=
         "$vruleLength eq 3 
         and 
          $pComponents[3] eq '('">
          
          <xsl:sequence select=
           "number($pComponents[2]/computedValue)"/>
       
       </xsl:when>
       <!-- arg1 op arg2 -->
       <xsl:otherwise>
         <xsl:variable name="vNum1" as="xs:double"
          select="number($pComponents[3]/computedValue)"/>
         
         <xsl:variable name="vNum2" as="xs:double"
          select="number($pComponents[1]/computedValue)"/>
          
         <xsl:variable name="vOp" as="xs:string"
          select="string($pComponents[2])"/>
          
          <xsl:sequence select=
           "if($vOp eq '+')
              then $vNum1 + $vNum2
              else if($vOp eq '-')
                 then $vNum1 - $vNum2
              else if($vOp eq '*')
                 then $vNum1 * $vNum2
              else if($vOp eq '/')
                 then $vNum1 div $vNum2
              else if($vOp eq '%')
                 then $vNum1 mod $vNum2
              else 'Error'
           "
           />
        </xsl:otherwise>
     </xsl:choose>
   </xsl:if>
<!--   -->
 </xsl:function>

 <xsl:variable name="vRegExSimpleExpr" as="xs:string">
   ([\s]*)          <!-- Skip leading whitespace -->
                    <!-- Followed by: -->
   (  
                               <!-- a Number -->
      ((([-]?[0-9]+)?\.)?[-]?[0-9]+([eE][-+]?[0-9]+)? )
    |
         [\+\-\*/%\(\)]            <!-- Or one of these:
                                   '+', '-', '*',
                                   '%', '/' 
                                   '(', ')'-->
                    
         <!--)-->
      )            <!-- These are all our token types -->
      (.*)$        <!-- Only get the first token,
                        Skip the rest for the future -->
 </xsl:variable>
 
 <xsl:function name="f:lexer-simpleExpr" as="element()">
  <f:lexer-simpleExpr/>
 </xsl:function>
 
 <xsl:template match="f:lexer-simpleExpr" as="item()*"
    mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:lexer-simpleExpr($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:lexer-simpleExpr" as="item()*">
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
		       regex="{$vRegExSimpleExpr}">

		      <xsl:matching-substring>
            <xsl:variable name="vToken" 
             select="regex-group(2)"/>

            <xsl:sequence select=
            "$pinpIndex
            +
             string-length(substring-before($vstrInput,$vToken))
            +
             string-length($vToken),
               
             if(regex-group(3))
                 then 'NUMBER'
                 else $vToken	
              ,
              $vToken            
            "
            />
		      </xsl:matching-substring>
		      
		      
		      <xsl:non-matching-substring>
		        <xsl:choose>
		          <xsl:when test="$pinpIndex eq string-length($pstrInput)">
		            <xsl:sequence select=
		             "$pinpIndex, '$end'
		             "/>
		          </xsl:when>
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