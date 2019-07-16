package util

import android.icu.text.DateFormat
import android.icu.text.SimpleDateFormat
import java.util.*

class DateUtil {

    object DateUtils {
        fun jsonDateToShortDate(jsonDate: String?): String {
//1
            if (jsonDate == null) { return "-" }
// 2
            val inFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
            // 3
            val date = inFormat.parse(jsonDate)
            // 4
            val outputFormat = DateFormat.getDateInstance(DateFormat.SHORT, Locale.getDefault())
// 6
            return outputFormat.format(date)
        }
    }


}