<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="xyz.jangle.demoname.dao.${beanName}Mapper">
	<resultMap id="BaseResultMap"
		type="xyz.jangle.demoname.model.${beanName}">
		<id column="id" jdbcType="BIGINT" property="id" />
		<#list columnList as row>
			<#if row.beanProperty != "id">
			<result column="${row.column}" jdbcType="${(row.jdbcType == 'INT')?string('INTEGER',(row.jdbcType=='DATETIME')?string('TIMESTAMP',row.jdbcType))}" property="${row.beanProperty}" />
			</#if>
		</#list>
	</resultMap>
	<sql id="all_column">
		<![CDATA[
			<#list columnList as row>
			${row.column}<#if row_has_next>,</#if>
			</#list>
		]]>
	</sql>
	<sql id="page_where">
		<where>
			<if test="status != null and status != ''">
				AND status = ${mybatisLeft}status}
			</if>
		</where>
	</sql>
	<delete id="deleteByPrimaryKey" parameterType="java.lang.Long">
		update ${tableName}
		set status = 2
		where id = ${mybatisLeft}id,jdbcType=BIGINT${mybatisRight}
	</delete>
	<delete id="batchDeleteByPrimaryKey" parameterType="xyz.jangle.demoname.model.${beanName}">
		update ${tableName}
		set status = 2
		where id in 
		<foreach close=")" collection="idsArray" item="listItem" open="(" separator=",">
                    ${mybatisLeft}listItem}
        </foreach>
	</delete>
	<insert id="insert"
		parameterType="xyz.jangle.demoname.model.${beanName}" useGeneratedKeys="true" keyProperty="id">
		insert into ${tableName} ( 
		<#list columnList as row>
			<#if row.beanProperty != "id">
			${row.column}<#if row_has_next>,</#if>
			</#if>
		</#list>
		)
		values (
		<#list columnList as row>
			<#if row.beanProperty != "id" >
			<#if row.beanProperty == "createTime" || row.beanProperty == "updateTime">
			now()<#if row_has_next>,</#if>
			<#else>
			${mybatisLeft}${row.beanProperty},jdbcType=${(row.jdbcType == 'INT')?string('INTEGER',(row.jdbcType=='DATETIME')?string('TIMESTAMP',row.jdbcType))}${mybatisRight}<#if row_has_next>,</#if>
			</#if>
			</#if>
		</#list>
		)
	</insert>
	<update id="updateByPrimaryKey"
		parameterType="xyz.jangle.demoname.model.${beanName}">
		<![CDATA[
		update ${tableName}
		set 
		<#list columnList as row>
			<#if row.beanProperty != "id" && row.beanProperty != "createTime" && row.beanProperty != "uuid" >
				<#if row.beanProperty == "updateTime">
				${row.column} = now()<#if row_has_next>,</#if>
				<#else>
				${row.column} = ${mybatisLeft}${row.beanProperty},jdbcType=${(row.jdbcType == 'INT')?string('INTEGER',(row.jdbcType=='DATETIME')?string('TIMESTAMP',row.jdbcType))}${mybatisRight}<#if row_has_next>,</#if>
				</#if>
			</#if>
		</#list>
		]]>
		<if test="id != null and id gt 0">
		where id = ${mybatisLeft}id,jdbcType=BIGINT}
		</if>
		<if test="(id == null or id lt 1 ) and uuid != null and uuid != ''">
		where uuid = ${mybatisLeft}uuid,jdbcType=VARCHAR}
		</if>
		<if test="(id == null or id lt 1 ) and (uuid == null or uuid == '')">
		where id = ${mybatisLeft}id,jdbcType=BIGINT}
		</if>
	</update>
	<select id="selectByPrimaryKey" parameterType="java.lang.Long"
		resultMap="BaseResultMap">
		select 
		<include refid="all_column" />
		from ${tableName}
		where id = ${mybatisLeft}id,jdbcType=BIGINT}
	</select>
	<select id="selectAll" resultMap="BaseResultMap">
		select 
		<include refid="all_column" />
		from ${tableName}
	</select>
	<select id="selectByParam" resultMap="BaseResultMap" parameterType="java.util.Map">
		select 
		<include refid="all_column" />
		from ${tableName}
		<include refid="page_where" />
	</select>
	<select id="selectPage" resultMap="BaseResultMap"
		parameterType="xyz.jangle.demoname.model.${beanName}">
		select 
		<include refid="all_column" />
		from ${tableName}
		<include refid="page_where" />
		order by id DESC
		limit ${mybatisLeft}pageStart,jdbcType=BIGINT},
		${mybatisLeft}pageSize,jdbcType=INTEGER}
	</select>
	<select id="selectPageCount" resultType="java.lang.Long"
		parameterType="xyz.jangle.demoname.model.${beanName}">
		select count(*)
		from ${tableName}
		<include refid="page_where" />
	</select>
</mapper>