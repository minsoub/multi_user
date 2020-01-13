package  kr.co.neodreams.multi_user.common;

import java.io.UnsupportedEncodingException;

public class ImKoreanUtil {
	public ImKoreanUtil()
    {
    }

    public static int getKorLength(String buf)
    {
        int datelen = 0;
        for(int i = 0; i < buf.length(); i++)
            try
            {
                char nn = buf.charAt(i);
                Character.UnicodeBlock uniTmp = Character.UnicodeBlock.of(nn);
                if(uniTmp == Character.UnicodeBlock.HANGUL_COMPATIBILITY_JAMO || uniTmp == Character.UnicodeBlock.HANGUL_JAMO || uniTmp == Character.UnicodeBlock.HANGUL_SYLLABLES)
                    datelen++;
                datelen++;
            }
            catch(Exception _ex)
            {
                System.out.println("\uB370\uC774\uD0C0 \uBD84\uC11D\uC2E4\uD328.");
            }

        return datelen;
    }

    public static String to8859(String src)
    {
        if(src == null)
            return "";
        try
        {
            String ret = new String(src.getBytes("KSC5601"), "8859_1");
            return ret;
        }
        catch(UnsupportedEncodingException _ex)
        {
            return src;
        }
        catch(Exception _ex)
        {
            return src;
        }
    }

    public static String toKSC(String src)
    {
        if(src == null)
            return "";
        try
        {
            String ret = new String(src.getBytes("8859_1"), "KSC5601");
            return ret;
        }
        catch(UnsupportedEncodingException _ex)
        {
            return src;
        }
        catch(Exception _ex)
        {
            return src;
        }
    }

    public static String toEUCKR(String src)
    {
        if(src == null)
            return "";
        try
        {
            String ret = new String(src.getBytes("8859_1"), "EUC-KR");
            return ret;
        }
        catch(UnsupportedEncodingException _ex)
        {
            return src;
        }
        catch(Exception _ex)
        {
            return src;
        }
    }
}
