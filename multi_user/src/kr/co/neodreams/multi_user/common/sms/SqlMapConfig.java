package kr.co.neodreams.multi_user.common.sms;

import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class SqlMapConfig {

    private static final SqlMapClient sqlMap;

    static {

        try {

            Reader reader = Resources.getResourceAsReader("sqlmap/Config.xml");

            sqlMap = SqlMapClientBuilder.buildSqlMapClient(reader);

        } catch (IOException e) {

            e.printStackTrace();

            throw new RuntimeException("초기화 에러: " + e);

        }
    }

    public static SqlMapClient getSqlMapInstance() {
        return sqlMap;
    }
}
