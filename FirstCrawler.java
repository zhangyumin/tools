import org.jsoup.*;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
/**
 * //
 * //   █████▒█    ██  ▄████▄   ██ ▄█▀       ██████╗ ██╗   ██╗ ██████╗
 * // ▓██   ▒ ██  ▓██▒▒██▀ ▀█   ██▄█▒        ██╔══██╗██║   ██║██╔════╝
 * // ▒████ ░▓██  ▒██░▒▓█    ▄ ▓███▄░        ██████╔╝██║   ██║██║  ███╗
 * // ░▓█▒  ░▓▓█  ░██░▒▓▓▄ ▄██▒▓██ █▄        ██╔══██╗██║   ██║██║   ██║
 * // ░▒█░   ▒▒█████▓ ▒ ▓███▀ ░▒██▒ █▄       ██████╔╝╚██████╔╝╚██████╔╝
 * //  ▒ ░   ░▒▓▒ ▒ ▒ ░ ░▒ ▒  ░▒ ▒▒ ▓▒       ╚═════╝  ╚═════╝  ╚═════╝
 * Created by joker on 16-4-2.
 */
public class FirstCrawler {
    public static void main(String[] args) throws IOException {
        String url = "http://zhangyumin.github.io/";
        Document doc = Jsoup.connect(url)
                .userAgent("Mozilla/5.0 (Windows NT 6.1; rv:30.0) Gecko/20100101 Firefox/30.0")
                .get();
        Elements elements = doc.select(".main .post");
        for(Element ele : elements){
            Elements elementTitle = ele.select(".post-title a");
            String title = elementTitle.text();
            String link = elementTitle.attr("href").trim();

            Elements elementSubTitle = ele.select(".post-meta");
            String time = ele.select(".post-meta").first().ownText();
            String tag = elementSubTitle.select("a").text();

            Elements elementSummary = ele.select(".post-main p");
            String summary = elementSummary.text();

            System.out.println("Link: http://zhangyumin.github.io" + link);
            System.out.println("Title: " + title);
            System.out.println("Time: " + time);
            System.out.println("Tag: " + tag);
            System.out.println("Abstract: " + summary);
            System.out.println();
        }
        System.out.println(elements.size());
    }
}
