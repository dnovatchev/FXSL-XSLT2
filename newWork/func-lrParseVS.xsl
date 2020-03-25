<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:key name="kActByStateSymb" match="@act" 
          use="concat(../../@number,'T', ..)"/>
 
 <xsl:key name="kRuleByPos" match="r"
          use="count(preceding-sibling::r)"/>
          
 <xsl:key name="kGotoState" match="@newState"
          use="concat(../@number,'NT',../@NT)"/>
 
 <xsl:variable name="vAccept" as="xs:integer"
               select="0"/>
  
 <xsl:variable name="vError" as="xs:integer"
               select="999999"/>
 
 <xsl:function name="f:lrParse" as="element()*">
   <xsl:param name="ppTables" as="element()"/>
   <xsl:param name="pInput" as="xs:string*"/>
   <xsl:param name="pInputInd" as="xs:integer"/>
   <xsl:param name="pStack" as="xs:integer+"/>
   <xsl:param name="pValStack" as="element()*"/>
   
   <xsl:variable name="vAct" as="xs:string?"
     select="key('kActByStateSymb',
                  concat($pStack[1],'T', 
                         $pInput[$pInputInd]
                         ),
                  $ppTables
                 )[1]"
   />
   <xsl:variable name="vAct2" as="xs:string?"
     select=
      "if($vAct != '')
        then 
          $vAct
        else
          key('kActByStateSymb',
                  concat($pStack[1],'T', 
                         '.'
                         ),
                  $ppTables
          )
     "
   />

<!--
   <xsl:message>
    $vAct:  <xsl:sequence select="$vAct"/>
    $vAct2: <xsl:sequence select="$vAct2"/>
   </xsl:message>
-->   

   <xsl:sequence select=
    "f:executeAct($ppTables,$pInput,$pInputInd,
                  $pStack,$pValStack,
                  $vAct2
                  )"
    />
 </xsl:function>
 
 <xsl:function name="f:executeAct" as="element()*">
   <xsl:param name="ppTables" as="element()"/>
   <xsl:param name="pInput" as="xs:string*"/>
   <xsl:param name="pInputInd" as="xs:integer"/>
   <xsl:param name="pStack" as="xs:integer+"/>
   <xsl:param name="pValStack" as="element()*"/>
   <xsl:param name="pAct" as="xs:string?"/>
   
<!--
   <xsl:message>
     Stack: <xsl:sequence select="$pStack"/>
     Input: <xsl:sequence select="$pInput[$pInputInd]"/>
     Action: <xsl:sequence select="$pAct"/>
     Value-Stack: <xsl:sequence select="$pValStack"/>
   </xsl:message>
-->   
   <xsl:choose>
     <xsl:when test="not($pAct)">
<!-- 
      <xsl:message>
         Error!
         
       </xsl:message>
-->
       <xsl:sequence select="$vError"/>
     </xsl:when>
     <xsl:when test="$pAct = 'acc'">
<!-- 
       <xsl:sequence select="$vAccept"/>
       
       Result:
-->       
<!--
       <xsl:message>
         Accept!
         
       </xsl:message>
-->
       <xsl:sequence select="$pValStack"/>
     </xsl:when>
     
     <!-- Shift N -->
     <xsl:when test="starts-with($pAct, 's')">
<!--
       <xsl:message>
         Shift <xsl:sequence select="substring($pAct,2)"/>!
         
       </xsl:message>
-->     

       <xsl:sequence select=
       "f:lrParse($ppTables,$pInput,$pInputInd+1,
                  (xs:integer(substring($pAct,2)),
                   $pStack),
                   (f:makeOp($pInput[$pInputInd]), $pValStack)
                  )"
       />
     </xsl:when>
     <!-- Reduce K -->
     <xsl:otherwise>
<!--
       <xsl:message>
         Reduce <xsl:sequence select="substring($pAct,2)"/>!
         
       </xsl:message>
-->     

       <xsl:variable name="vRuleNo" as="xs:integer"
            select="xs:integer(substring($pAct,2))"/>
       
       <xsl:variable name="vRule" as="element()"
        select="key('kRuleByPos',$vRuleNo,$ppTables)"/>
                     
       <!-- <xsl:sequence select="$vRuleNo"/> -->
       
       <xsl:variable name="vRuleOutput" as="element()"
         select="f:ruleOutput($vRule, $pValStack)"
       />
        
       <xsl:variable name="vredcStack" as="xs:integer+"
        select="subsequence($pStack,1 + $vRule/@length)"/>
        
       <xsl:variable name="vredcValStack" as="item()*"
        select="subsequence($pValStack,1 + $vRule/@length)"/>
<!--
   <xsl:message>
     Reduce:
     Stack: <xsl:sequence select="$pStack"/>
     ValStack: <xsl:sequence select="$pValStack"/>
     Input: <xsl:sequence select="$pInput[$pInputInd]"/>
     Action: <xsl:sequence select="$pAct"/>
     RuleNo: <xsl:sequence select="$vRuleNo"/>
     $vRule: <xsl:sequence select="$vRule"/>
     $vRuleOutput: <xsl:sequence select="$vRuleOutput"/>
     $vredcStack: <xsl:sequence select="$vredcStack"/>
     $vredcValStack: <xsl:sequence select="$vredcValStack"/>
   </xsl:message>
-->   
       <xsl:variable name="vNewState" as="xs:integer"
        select="xs:integer(
		                key('kGotoState', 
		                     concat($vredcStack[1],'NT',
		                            $vRule/@left
		                            ),
		                     $ppTables)
		                        )"/>
        
       <xsl:sequence select=
       "f:lrParse($ppTables,$pInput,$pInputInd,
                  ($vNewState,$vredcStack),
                   ($vRuleOutput, $vredcValStack)
                  )"
       />
     </xsl:otherwise>
   </xsl:choose>
 </xsl:function>

 <xsl:function name="f:ruleOutput" as="element()">
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

 <xsl:function name="f:makeOp" as="element()">
   <xsl:param name="pSymbol" as="item()"/>
   
   <term><xsl:sequence select="$pSymbol"/></term>
 </xsl:function>

 <xsl:function name="f:computedValue" as="item()*">
   <xsl:param name="pComponents" as="element()*"/>
   <xsl:param name="pLength" as="xs:integer"/>
   
   <xsl:message>
    f:computedValue:
      Length: <xsl:sequence select="$pLength"/>
      Components: <xsl:sequence select="$pComponents"/>
   </xsl:message>
   
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




 <xsl:function name="f:lrParse2" as="xs:integer*">
   <xsl:param name="ppTables" as="element()"/>
   <xsl:param name="pInput" as="xs:string*"/>
   <xsl:param name="pInputInd" as="xs:integer"/>
   <xsl:param name="pStack" as="xs:integer+"/>
   
   <xsl:variable name="vAct" as="xs:string?"
     select="key('kActByStateSymb',
                  concat($pStack[1],'T', 
                         $pInput[$pInputInd]
                         ),
                  $ppTables
                 )[1]"
   />
   <xsl:variable name="vAct2" as="xs:string?"
     select=
      "if($vAct != '')
        then 
          $vAct
        else
          key('kActByStateSymb',
                  concat($pStack[1],'T', 
                         '.'
                         ),
                  $ppTables
          )
     "
   />

<!--
   <xsl:message>
    $vAct:  <xsl:sequence select="$vAct"/>
    $vAct2: <xsl:sequence select="$vAct2"/>
   </xsl:message>
-->   

   <xsl:choose>
     <xsl:when test="not($vAct2)">
       <xsl:value-of select="$vError"/>
     </xsl:when>
     <xsl:when test="$vAct2 = 'acc'">
       <xsl:value-of select="$vAccept"/>
     </xsl:when>
     <!-- Shift N -->
     <xsl:when test="starts-with($vAct2, 's')">
       <xsl:sequence select=
       "f:lrParse2($ppTables,$pInput,$pInputInd+1,
                  (xs:integer(substring($vAct2,2)),
                   $pStack)
                  )"
       />
     </xsl:when>
     <!-- Reduce K -->
     <xsl:otherwise>
       <xsl:variable name="vRuleNo" as="xs:integer"
            select="xs:integer(substring($vAct2,2))"/>
       
       <xsl:value-of select="$vRuleNo"/>
        
       <xsl:variable name="vRule" as="element()"
        select="key('kRuleByPos',$vRuleNo,$ppTables)"/>
                     
       <xsl:variable name="vredcStack" as="xs:integer+"
        select="subsequence($pStack,1 + $vRule/@length)"/>
<!--
   <xsl:message>
     Reduce:
     Stack: <xsl:sequence select="$pStack"/>
     Input: <xsl:sequence select="$pInput[$pInputInd]"/>
     Action: <xsl:sequence select="$pAct"/>
     RuleNo: <xsl:sequence select="$vRuleNo"/>
     $vRule: <xsl:sequence select="$vRule"/>
     $vredcStack: <xsl:sequence select="$vredcStack"/>
   </xsl:message>
-->   
       <xsl:variable name="vNewState" as="xs:integer"
        select="xs:integer(
		                key('kGotoState', 
		                     concat($vredcStack[1],'NT',
		                            $vRule/@left
		                            ),
		                     $ppTables)
		                        )"/>
        
       <xsl:sequence select=
       "f:lrParse2($ppTables,$pInput,$pInputInd,
                  ($vNewState,$vredcStack)
                  )"
       />
     </xsl:otherwise>
   </xsl:choose>
 </xsl:function>
</xsl:stylesheet>