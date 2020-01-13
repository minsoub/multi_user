package kr.co.neodreams.multi_user.base.dao;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;

public class BaseDao extends SqlMapClientDaoSupport{

    protected Logger log = LoggerFactory.getLogger(this.getClass());    // Log

    @Resource(name = "sqlMapClient")
    public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSqlMapClient(sqlMapClient);
    }

    public Object insert(String queryId, Object parameterObject) {
        return getSqlMapClientTemplate().insert(queryId, parameterObject);
    }

    public int update(String queryId, Object parameterObject) {
        return getSqlMapClientTemplate().update(queryId, parameterObject);
    }

    public int delete(String queryId, Object parameterObject) {
        return getSqlMapClientTemplate().delete(queryId, parameterObject);
    }

    public Object select(String queryId, Object parameterObject) {
        return getSqlMapClientTemplate().queryForObject(queryId, parameterObject);
    }

    public List<?> list(String queryId, Object parameterObject) {
        return getSqlMapClientTemplate().queryForList(queryId, parameterObject);
    }

    public List<?> list(String queryId, Object parameterObject, int pageSize, int pageIndex) {
        return getSqlMapClientTemplate().queryForList(queryId, parameterObject,
                pageSize * pageIndex, pageSize);
    }

    public int getCount(String queryId, Object parameterObject) {
        return ((Integer)getSqlMapClientTemplate().queryForObject(queryId, parameterObject)).intValue();
    }

}
