<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="../f/func-apply.xsl"/>
 
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
   <xsl:param name="pCurLexeme" as="element()?"/>
   <xsl:param name="pStack" as="xs:integer+"/>
   <xsl:param name="pValStack" as="element()*"/>
   <xsl:param name="pFunLex" as="element()"/>
   <xsl:param name="pFunOnRuleReduced" as="element()"/>

<!-- Call Lexer here! -->
  
  <xsl:variable name="vLexResults" as="item()+"
   select="f:apply($pFunLex, $pInput, $pInputInd)"/>
   
     <xsl:variable name="vToken" as="xs:string"
     select="$vLexResults[2]"/>
     
    <xsl:variable name="vValue" as="item()?"
     select="$vLexResults[3]"/>
     
    <xsl:variable name="vnewIndex" as="xs:integer"
     select="$vLexResults[1]"/>
  
    <xsl:variable name="vCurLexeme" as="element()">
	    <term name="{$vToken}">
	      <xsl:choose>
			    <xsl:when test="$vToken eq 'error'">
			      <xsl:attribute name="at" select="$pInputInd"/>
			    </xsl:when>
			    <xsl:otherwise>
			      <xsl:sequence select="$vValue"/>
			    </xsl:otherwise>
	      </xsl:choose>
	    </term>
    </xsl:variable>
    
   <xsl:choose>
    <xsl:when test="$vToken eq 'error'">
      <xsl:sequence select=
        "$pCurLexeme, $pValStack"/>
    </xsl:when>
    
    <xsl:otherwise>
		   <xsl:variable name="vAct" as="xs:string?"
		     select="key('kActByStateSymb',
		                  concat($pStack[1],'T', 
		                         $vToken
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
		   <xsl:choose>
		     <xsl:when test="not($vAct2)">
		<!-- 
		      <xsl:message>
		         Error!
		         
		       </xsl:message>
		-->
		       <xsl:variable name="verrNT" as="element()">
		         <NonTerminal name="Error" at="{$pInputInd}"/>
		       </xsl:variable>
		       <xsl:sequence select="$verrNT, $pValStack"/>
		     </xsl:when>
		     <!-- acc, shift or reduce -->
		     <xsl:when test="$vAct2 = 'acc'">
<!--		       
		       <xsl:variable name="vRule" as="element()"
		        select="key('kRuleByPos',1,$ppTables)"/>
		      
		        <xsl:sequence select=
		           "f:apply($pFunOnRuleReduced, 
		                    $vRule, $pValStack
		                    )"
		       />
-->		     
		        <xsl:sequence select="$pValStack"/> 
		     </xsl:when>
		     
		     <!-- Shift N -->
		     <xsl:when test="starts-with($vAct2, 's')">
		<!--
		       <xsl:message>
		         Shift <xsl:sequence select="substring($pAct,2)"/>!
		         
		       </xsl:message>
		-->     
		
		       <xsl:sequence select=
		       "f:lrParse($ppTables,$pInput,$vnewIndex,
		                  $vCurLexeme,
		                  (xs:integer(substring($vAct2,2)),
		                   $pStack),
		                   ($vCurLexeme, $pValStack),
		                   $pFunLex,
		                   $pFunOnRuleReduced
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
		            select="xs:integer(substring($vAct2,2))"/>
		       
		       <xsl:variable name="vRule" as="element()"
		        select="key('kRuleByPos',$vRuleNo,$ppTables)"/>
		                     
		       <!-- <xsl:sequence select="$vRuleNo"/> -->
		       
		       <xsl:variable name="vRuleOutput" as="element()"
		         select="f:apply($pFunOnRuleReduced, 
		                         $vRule, $pValStack
		                         )"
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
		                  $vCurLexeme,
		                  ($vNewState,$vredcStack),
		                  ($vRuleOutput, $vredcValStack),
		                   $pFunLex,
		                   $pFunOnRuleReduced
		                  )"
		       />
		     </xsl:otherwise>
		   </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>


  
   

<!--
   <xsl:message>
    $vAct:  <xsl:sequence select="$vAct"/>
    $vAct2: <xsl:sequence select="$vAct2"/>
   </xsl:message>
-->   

 </xsl:function>

</xsl:stylesheet>