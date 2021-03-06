<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE sqlMap PUBLIC "-//iBATIS.com//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd">
<sqlMap namespace="${beanName}">
	<!-- ${versionInfo} huhj ${tableRemarks} ibatis配置文件 -->
	<typeAlias alias="${beanNameVar}" type="com.fline.zjoa.access.model.${beanName}" />
	<resultMap id="${beanNameVar}Result" class="${beanNameVar}">
		<!-- NamespaceModel -->
			<result property="id" column="ID" javaType="long" jdbcType="NUMERIC" nullValue="0" />
		<#list columnList as row>
			<#if row.beanProperty != "id">
			<result property="${row.beanProperty}" column="${row.column}" javaType="${row.javaType}" jdbcType="${row.jdbcType}"/>
			</#if>
		</#list>
	</resultMap>
	<sql id="sql_sequence">
		<![CDATA[
		SELECT LAST_INSERT_ID() AS ID
		]]>
	</sql>
	<select id="sequence">
		<include refid="sql_sequence" />
	</select>
	<sql id="all_column">
		<![CDATA[
			<#list columnList as row>
			${row.column}<#if row_has_next>,</#if>
			</#list>
		]]>
	</sql>
	<insert id="create" parameterClass="${beanNameVar}">
		
		<![CDATA[
		INSERT INTO ${tableName} (
			<#list columnList as row>
			<#if row.beanProperty != "id">
			${row.column}<#if row_has_next>,</#if>
			</#if>
			</#list>
		) VALUES (
			<#list columnList as row>
			<#if row.beanProperty != "id" >
			<#if row.beanProperty == "oaCreateTime" || row.beanProperty == "oaUpdateTime">
			now()<#if row_has_next>,</#if>
			<#elseif row.beanProperty == "oaUuid">
			REPLACE(UUID(), '-', '')<#if row_has_next>,</#if>
			<#else>
			#${row.beanProperty}#<#if row_has_next>,</#if>
			</#if>
			</#if>
			</#list>
		)
		]]>
		<selectKey keyProperty="id" resultClass="long">
			<include refid="sql_sequence" />
		</selectKey>
	</insert>
	<update id="update" parameterClass="${beanNameVar}">
		<![CDATA[
		UPDATE ${tableName} SET
		<#list columnList as row>
			<#if row.beanProperty != "id" && row.beanProperty != "oaCreateTime" && row.beanProperty != "oaUuid" >
				<#if row.beanProperty == "oaUpdateTime">
				${row.column} = now()<#if row_has_next>,</#if>
				<#else>
				${row.column} = #${row.beanProperty}#<#if row_has_next>,</#if>
				</#if>
			</#if>
		</#list>
		WHERE id=#id#
		]]>
	</update>
	<delete id="remove" parameterClass="${beanNameVar}">
		<![CDATA[
			DELETE FROM ${tableName} WHERE id=#id#
		]]>
	</delete>
	<select id="findById" parameterClass="Long" resultMap="${beanNameVar}Result">
			SELECT
			<include refid="all_column"/>
			FROM ${tableName} A WHERE id=#id#
	</select>
	<select id="findByOaUuid" parameterClass="${beanNameVar}" resultMap="${beanNameVar}Result">
			SELECT
			<include refid="all_column"/>
			FROM ${tableName} A WHERE oa_uuid=#oaUuid#
	</select>
	<sql id="sql_where">
		<dynamic prepend="WHERE">
			
		</dynamic>
	</sql>
	<sql id="sql_from">
		FROM ${tableName} A
		<include refid="sql_where" />
	</sql>
	<select id="findAll" resultMap="${beanNameVar}Result">
		SELECT
		<include refid="all_column"/>
		<include refid="sql_from" />
	</select>
	<select id="find" resultMap="${beanNameVar}Result">
		SELECT
		<include refid="all_column"/>
		<include refid="sql_from" />
		<isNotNull property="_orderBy">
			order by $_orderBy$
		</isNotNull>
		<isGreaterThan property="_maxResult" compareValue="0">
			<![CDATA[ limit #_skipResult#, #_pageSize#]]>
		</isGreaterThan>
	</select>
	<select id="find_count" parameterClass="java.util.Map" resultClass="int">
		<![CDATA[ SELECT COUNT(*) ]]>
		<include refid="sql_from" />
	</select>
</sqlMap>