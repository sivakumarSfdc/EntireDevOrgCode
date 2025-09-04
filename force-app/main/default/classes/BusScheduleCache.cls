public class BusScheduleCache {
    private Cache.OrgPartition part;
    
    public BusScheduleCache() {
        part = Cache.Org.getPartition('local.BusSchedule');
    }
    
    public void putSchedule(String busLine, Time[] schedule) {
        part.put(busLine, schedule);
    }
    
    public Time[] getSchedule(String busLine) {
        Time[] schedule = (Time[])part.get(busLine);
        if (schedule == null) {
            // Handling cache misses
            schedule = new Time[]{
                Time.newInstance(8, 0, 0, 0), // 8am
                Time.newInstance(17, 0, 0, 0) // 5pm
            };
        }
        return schedule;
    }
}