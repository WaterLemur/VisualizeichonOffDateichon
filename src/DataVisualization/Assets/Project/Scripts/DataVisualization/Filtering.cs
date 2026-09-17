public interface IDataFilter
{
    bool Matches(DataRecord record);
}




public class RangeFilter
{

}

public class CategoryFilter
{

}

public class DateFilter
{

}


public class YearFilter : IDataFilter
{
    private int year;

    public YearFilter(int year)
    {
        this.year = year;
    }

    public bool Matches(DataRecord record)
    {
        //return record.Year == year;
        return true;
    }
}