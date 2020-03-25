<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="func-MemoryId.xsl"/>
 <xsl:import href="../f/func-foldl.xsl"/>
 
 <xsl:variable name="pXSLT-Style" select="0"/>
 <xsl:variable name="pXPath-Style" select="1"/>
 
 <xsl:template match="/">

    <!-- Allocate and initialize memory -->
    <xsl:variable name="vMem"
     select="f:memNew(1 to 10)"/>
     
    <!-- Create Tree, top=5 -->
    <xsl:variable name="vMem2" select="f:makeBTree(5, $vMem)"/>
    
     <!-- Add node = 3 -->
     <xsl:variable name="vMem3" select="f:btAddElem(3, $vMem2[1], $vMem2)"/>

     <!-- Add node = 8 -->
     <xsl:variable name="vMem4" select="f:btAddElem(8, $vMem3[1], $vMem3)"/>

     <!-- Add node = 9 -->
     <xsl:variable name="vMem5" select="f:btAddElem(9, $vMem4[1], $vMem4)"/>

     <!-- Add node = 1 -->
     <xsl:variable name="vMem6" select="f:btAddElem(1, $vMem5[1], $vMem5)"/>

     <!-- Add node = 4 -->
     <xsl:variable name="vMem7" select="f:btAddElem(4, $vMem6[1], $vMem6)"/>
     <!-- Add node = 7 -->
     <xsl:variable name="vMem8" select="f:btAddElem(7, $vMem7[1], $vMem7)"/>

<!--
===================

  <xsl:sequence select="f:printTree($vMem8[1], $vMem8)"/>     

===================
-->     
     <!-- Add node = 7 -->
     <xsl:variable name="vMem9" select="f:btAddElem(7, $vMem8[1], $vMem8)"/>
        
   f:btMember(7,$vMem9[1], $vMem9) = <xsl:sequence select=
    "f:btMember(7,$vMem9[1], $vMem9) "/>

===================
        
   f:btMember(6,$vMem9[1], $vMem9) = <xsl:sequence select=
    "f:btMember(6,$vMem9[1], $vMem9) "/>
 </xsl:template>
 
 <xsl:function name="f:makeBTree" as="item()*">
   <xsl:param name="pTop" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   
   <xsl:if test="(not(empty($pTop)))">
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
   
   <xsl:if test="(not(empty($pTop)))">
     <xsl:variable name="vTopElem" as="element()">
       <e indv="{$pTop}">
         <xsl:if test="not(empty($pleftT))">
           <xsl:attribute name="il" select="$pleftT"/>
         </xsl:if>
       
         <xsl:if test="not(empty($prightT))">
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
   <xsl:param name="pX" as="xs:integer"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>

   <xsl:if test="$pXSLT-Style">
	   <xsl:choose>
	     <xsl:when test="empty($pTree)">
	       <xsl:sequence select="false()"/>
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:variable name="valX" select="f:memGet($pMem,$pX)"/>
	       <xsl:variable name="valTree" select="f:memGet($pMem,$pTree)"/>
	       <xsl:variable name="vtopVal" select="f:memGet($pMem,$valTree/@indv)"/>
	       <xsl:variable name="vindLTree" select="$valTree/@il"/>
	       <xsl:variable name="vindRTree" select="$valTree/@ir"/>
	       
	       <xsl:choose>
	         <xsl:when test="$valX lt $vtopVal">
	           <xsl:sequence select="f:btMember($pX, $vindLTree,$pMem)"/>
	         </xsl:when>
	         <xsl:when test="$valX gt $vtopVal">
	           <xsl:sequence select="f:btMember($pX, $vindRTree,$pMem)"/>
	         </xsl:when>
	         <xsl:otherwise>
			       <xsl:sequence select="true()"/>
	         </xsl:otherwise>
	       </xsl:choose>
	     </xsl:otherwise>
	   </xsl:choose>
   </xsl:if> <!-- pXSLT-Style -->
   
   
   <xsl:if test="$pXPath-Style">
	   <xsl:sequence select=
	    "if(empty($pTree))
	       then false()
	       else
	         for $valX in f:memGet($pMem,$pX),
	             $valTree in  f:memGet($pMem,$pTree),
	             $vtopVal in f:memGet($pMem,$valTree/@indv),
	             $vindLTree in $valTree/@il,
	             $vindRTree in $valTree/@ir
	           return
			         if($valX lt $vtopVal)
			            then f:btMember($pX, $vindLTree,$pMem)
			            else 
			              if($valX gt $vtopVal)
			                then f:btMember($pX, $vindRTree,$pMem)
			                else true()
			              
	    "
	   />
   </xsl:if>   <!-- $pXPath-Style -->
 </xsl:function>
 
  <xsl:function name="f:btAddElem" as="item()*">
   <xsl:param name="pX" as="xs:integer"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
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
	     <xsl:variable name="valX" select="f:memGet($pMem,$pX)"/>
	     <xsl:variable name="valTree" select="f:memGet($pMem,$pTree)"/>
	     <xsl:variable name="vtopVal" select="f:memGet($pMem,$valTree/@indv)"/>
	     <xsl:variable name="vindLTree" select="$valTree/@il"/>
	     <xsl:variable name="vindRTree" select="$valTree/@ir"/>
	     
	     <xsl:choose>
	       <xsl:when test="$valX lt $vtopVal">
	         <xsl:variable name="vMem2" 
	            select="f:btAddElem($pX, $vindLTree,$pMem)"/>
	         <xsl:sequence select=
	          "if($vMem2[1] gt $pMem[1])
	              then
				          f:makeBTree(
					                     $vtopVal,
					                     $vMem2[1],
					                     $vindRTree,
					                     $vMem2
					                     )
					      else
					        $pMem
              "
	          />
	       </xsl:when>
	       <xsl:when test="$valX gt $vtopVal">
	         <xsl:variable name="vMem2" 
	            select="f:btAddElem($pX, $vindRTree,$pMem)"/>
	         <xsl:sequence select=
	          "if($vMem2[1] gt $pMem[1])
	              then
			           f:makeBTree(
		                         $vtopVal,
		                         $vindLTree,
			                       $vMem2[1],
			                       $vMem2
		                         )
					      else
					        $pMem
           "
	          />
	       </xsl:when>
	       <xsl:otherwise>
	         <xsl:sequence select="$pMem"/>
	       </xsl:otherwise>
	     </xsl:choose>
<!---->
	   </xsl:otherwise>
   </xsl:choose>
  </xsl:function>
  
  <xsl:function name="f:printTree" as="element()">
    <xsl:param name="pTree" as="xs:integer?"/>
    <xsl:param name="pMem" as="item()*"/>
	     
    <xsl:if test="not(empty($pTree))">
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