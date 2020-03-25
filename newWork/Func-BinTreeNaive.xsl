<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="func-MemoryId.xsl"/>
 
 <xsl:function name="f:makeBTree" as="item()*">
   <xsl:param name="pTop" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   
   <xsl:if test="(exists($pTop))">
     <xsl:variable name="vTopElem" as="element()">
       <e indv="{$pTop}"/>
     </xsl:variable>
     
     <xsl:sequence select=
      "f:memAdd($pMem, $vTopElem)"
      />
   </xsl:if>
 </xsl:function>
 
 <xsl:function name="f:makeBTree" as="item()*">
   <xsl:param name="pTop" as="xs:integer?"/>
   <xsl:param name="pleftT" as="xs:integer?"/>
   <xsl:param name="prightT" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   <xsl:if test="(exists($pTop))">
     <xsl:variable name="vTopElem" as="element()">
       <e indv="{$pTop}">
         <xsl:if test="exists($pleftT)">
           <xsl:attribute name="il" select="$pleftT"/>
         </xsl:if>
       
         <xsl:if test="exists($prightT)">
           <xsl:attribute name="ir" select="$prightT"/>
         </xsl:if>
       </e>
     </xsl:variable>
     
     <xsl:sequence select=
      "f:memAdd($pMem, $vTopElem)"
      />
   </xsl:if>
 </xsl:function> 
 
 <xsl:function name="f:btMember" as="xs:boolean">
   <xsl:param name="pX" as="item()"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
<!--   
   <xsl:message>
   In f:btMember():
     $pX = '<xsl:sequence select="$pX"/>'
     $pTree = '<xsl:sequence select="$pTree"/>'
     $pMem = '<xsl:sequence select="$pMem"/>'
     
     $valX = '<xsl:sequence select="f:memGet($pMem,$pX)"/>'
     $valTree = '<xsl:sequence select="f:memGet($pMem,$pTree)"/>'
     $vtopVal = '<xsl:sequence select="f:memGet($pMem,f:memGet($pMem,$pTree)/@indv)"/>'
     $vindLTree = '<xsl:sequence select="f:memGet($pMem,$pTree)/@il"/>'
     $vindRTree = '<xsl:sequence select="f:memGet($pMem,$pTree)/@ir"/>'
     
         
     empty($vindLTree): '<xsl:sequence select="empty(f:memGet($pMem,$pTree)/@il)"/>'
     empty($vindRTree): '<xsl:sequence select="empty(f:memGet($pMem,$pTree)/@ir)"/>'
   </xsl:message>
-->   

   <xsl:sequence select=
    "if(empty($pTree))
       then false()
       else
         for 
             $valTree in  f:memGet($pMem,$pTree),
             $vtopVal in f:memGet($pMem,$valTree/@indv)
           return
		         if($pX lt $vtopVal)
		            then f:btMember($pX, $valTree/@il,$pMem)
		            else 
		              if($pX gt $vtopVal)
		                then f:btMember($pX, $valTree/@ir,$pMem)
		                else true()
		              
    "
   />
<!---->   
 </xsl:function>
  <xsl:function name="f:btMember2" as="xs:boolean">
   <xsl:param name="pX" as="item()"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pCandidate" as="xs:integer"/>
<!--   
   <xsl:message>
   In f:btMember():
     $pX = '<xsl:sequence select="$pX"/>'
     $pTree = '<xsl:sequence select="$pTree"/>'
     $pMem = '<xsl:sequence select="$pMem"/>'
     
     $valX = '<xsl:sequence select="f:memGet($pMem,$pX)"/>'
     $valTree = '<xsl:sequence select="f:memGet($pMem,$pTree)"/>'
     $vtopVal = '<xsl:sequence select="f:memGet($pMem,f:memGet($pMem,$pTree)/@indv)"/>'
     $vindLTree = '<xsl:sequence select="f:memGet($pMem,$pTree)/@il"/>'
     $vindRTree = '<xsl:sequence select="f:memGet($pMem,$pTree)/@ir"/>'
     
         
     empty($vindLTree): '<xsl:sequence select="empty(f:memGet($pMem,$pTree)/@il)"/>'
     empty($vindRTree): '<xsl:sequence select="empty(f:memGet($pMem,$pTree)/@ir)"/>'
   </xsl:message>
-->   

   <xsl:sequence select=
    "if(empty($pTree))
       then $pX = $pCandidate
       else
         for 
             $valTree in  f:memGet($pMem,$pTree),
             $vtopVal in f:memGet($pMem,$valTree/@indv)
           return
		         if($pX lt $vtopVal)
		            then f:btMember2($pX, $valTree/@il,$pMem,$pCandidate)
		            else 
		                 f:btMember2($pX, $valTree/@ir,$pMem, $vtopVal)
		              
    "
   />
<!---->   
 </xsl:function>
 
  <xsl:function name="f:btAddElem" as="item()*">
   <xsl:param name="pX" as="xs:integer"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
<!--   
   <xsl:message>
    f:btAddElem: 
	             $pX: '<xsl:sequence select="$pX"/>'
	          $pTree: '<xsl:sequence select="$pTree"/>'
	           $pMem: '<xsl:sequence select="$pMem"/>'

   </xsl:message>
-->  
   <xsl:choose>
	   <xsl:when test="(empty($pTree))">
	     <xsl:variable name="vTopElem" as="element()">
	       <e indv="{$pX}"/>
	     </xsl:variable>
	     
	     <xsl:sequence select=
	      "f:memAdd($pMem, $vTopElem)"
	      />
	   </xsl:when>
	   <!-- Insert in an existing tree -->
	   <xsl:otherwise>
<!--	     
	     <xsl:message>
	        Adding to a non-empty tree:
	         $valX   : '<xsl:sequence select="f:memGet($pMem,$pX)"/>' 
	         $valTree: '<xsl:sequence select="f:memGet($pMem,$pTree)"/>'
	         $vtopVal: '<xsl:sequence select="f:memGet($pMem,f:memGet($pMem,$pTree)/@indv)"/>'
	         $vindLTree: '<xsl:sequence select="f:memGet($pMem,$pTree)/@il"/>'
	         $vindRTree: '<xsl:sequence select="f:memGet($pMem,$pTree)/@ir"/>'
	     </xsl:message>
-->	     
	     
	     <xsl:variable name="valX" select="f:memGet($pMem,$pX)"/>
	     <xsl:variable name="valTree" select="f:memGet($pMem,$pTree)"/>
	     <xsl:variable name="vtopVal" select="f:memGet($pMem,$valTree/@indv)"/>
	     <xsl:variable name="vindLTree" select="$valTree/@il"/>
	     <xsl:variable name="vindRTree" select="$valTree/@ir"/>
	     <xsl:variable name="vbLessThanTop" as="xs:boolean"
	          select="$valX lt $vtopVal"/>
	     <xsl:variable name="vMem2" select=
			      "if($vbLessThanTop)
			         then f:btAddElem($pX, $vindLTree,$pMem)
			       else if($valX gt $vtopVal)
			         then f:btAddElem($pX, $vindRTree,$pMem)
			         else $pMem    
			      "
	      />
	      
	      <xsl:sequence select=
	       "if($vMem2[1] eq $pMem[1])
	          then $pMem
	          else
	            if($vbLessThanTop)
	              then 
				          f:makeBTree(
					                     $vtopVal,
					                     $vMem2[1],
					                     $vindRTree,
					                     $vMem2
					                     )
					      else
			           f:makeBTree(
		                         $vtopVal,
		                         $vindLTree,
			                       $vMem2[1],
			                       $vMem2
		                         )
					      
         "
	       />

	   </xsl:otherwise>
   </xsl:choose>
  </xsl:function>
  
  <xsl:function name="f:printTree" as="element()*">
    <xsl:param name="pTree" as="xs:integer?"/>
    <xsl:param name="pMem" as="item()*"/>
	     
    <xsl:if test="exists($pTree)">
	    <xsl:variable name="valTree" select="f:memGet($pMem,$pTree)"/>
	    <xsl:variable name="vtopVal" select="f:memGet($pMem,$valTree/@indv)"/>
	    <xsl:variable name="vindLTree" select="$valTree/@il"/>
	    <xsl:variable name="vindRTree" select="$valTree/@ir"/>
	    
	    <node val="{$vtopVal}">
	      <xsl:sequence select="f:printTree($vindLTree, $pMem)"/>
	      <xsl:sequence select="f:printTree($vindRTree, $pMem)"/>
	    </node>
    </xsl:if>
  </xsl:function>

</xsl:stylesheet>