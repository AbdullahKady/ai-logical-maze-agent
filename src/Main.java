import java.util.Scanner;

public class Main {
    public static void GenGrid(String grid) {
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
        // Write initial state predicates to KB.pl based on the grid.
    }

    public static void main(String args[]) {
        GenGrid("5,5;1,2;3,4;1,1,2,1,2,2,3,3");
    }
}
