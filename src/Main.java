import java.io.PrintWriter;
import java.util.Scanner;

public class Main {
    public static void GenGrid(String grid, String filePath) {
        Scanner scanner = new Scanner(grid);
        scanner.useDelimiter(";|,");
        // m,n;ix,iy;tx,ty; s1x,s1y,s2x,s2y,s3x,s3y,s4x,s4y
        int[] dimensions = { scanner.nextInt(), scanner.nextInt() };
        int[] ironMan = { scanner.nextInt(), scanner.nextInt() };
        int[] thanos = { scanner.nextInt(), scanner.nextInt() };
        int[][] stones = new int[4][2];
        for (int i = 0; i < stones.length; i++) {
            stones[i][0] = scanner.nextInt();
            stones[i][1] = scanner.nextInt();
        }
        try {
            PrintWriter writer = new PrintWriter(filePath, "UTF-8");
            String gridPredicate = String.format("grid_dimensions(%d, %d).", dimensions[0], dimensions[1]);
            String stonesList = "[";
            for (int[] stone : stones) {
                stonesList += String.format("[%d, %d], ", stone[0], stone[1]);
            }
            // Hacky way to get rid of extra comma.
            stonesList = stonesList.substring(0, stonesList.length() - 2) + "]";
            String ironManPredicate = String.format("ironman_position(%d, %d, %s, s0).", ironMan[0], ironMan[1],
                    stonesList);
            String thanosPredicate = String.format("thanos(%d, %d, s0).", thanos[0], thanos[1]);
            writer.println(gridPredicate);
            writer.println(ironManPredicate);
            writer.println(thanosPredicate);
            writer.close();
        } catch (Exception e) {
            // TODO: handle exception
        }
        // Write initial state predicates to KB.pl based on the grid.
    }

    public static void main(String args[]) {
        // TODO: Hard code 2 KB1, KB2 files.
        GenGrid("5,5;1,2;3,4;1,1,2,1,2,2,3,3", "KB1.pl");
        GenGrid("5,5;1,2;3,4;1,1,2,1,2,2,3,3", "KB2.pl");
    }
}
